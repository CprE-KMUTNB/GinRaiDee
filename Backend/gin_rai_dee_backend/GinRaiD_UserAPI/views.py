from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework import filters
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.settings import api_settings
from rest_framework.permissions import IsAuthenticated
from . import serializers,models,permissions
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from django.db.models.signals import post_save,pre_save,post_delete
from django.dispatch import receiver

@receiver(post_delete, sender=models.UserProfile)
def post_save_image(sender, instance, *args, **kwargs):
    try:
        instance.userpic.delete(save=False)
    except:
        pass

@receiver(pre_save, sender=models.UserProfile)
def pre_save_image(sender, instance, *args, **kwargs):
    try:
        old_img = instance.__class__.objects.get(id=instance.id).userpic
        try:
            new_img = instance.userpic
        except:
            new_img = None
        if new_img != old_img:
            try:
                instance.__class__.objects.get(id=instance.id).userpic.delete(save=False)
            except:
                pass
    except:
        pass


class UserRegisterViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.UserRegisterSerializer
    queryset = models.UserProfile.objects.all()
    authentication_classes = (TokenAuthentication,)
    permission_classes = (permissions.UpdateOwnProfile,)
    http_method_names = ['post','get',]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class UserPicViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.UserPicSerializer
    queryset = models.UserProfile.objects.all()
    http_method_names = ['get','put', ]
    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,filters.OrderingFilter,)
    ordering_fields = ['username']
    search_fields = ('username',)


class UserNameViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.UserNameSerializer
    queryset = models.UserProfile.objects.all()
    http_method_names = ['get','put', ]
    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,filters.OrderingFilter,)
    search_fields = ('username',)
    ordering_fields = ['username']


class UserPasswordViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.PasswordSerializer
    queryset = models.UserProfile.objects.all()
    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated,
    )
    http_method_names = ['put','get', ]
    filter_backends = (filters.SearchFilter,)
    search_fields = ('username',)
    
    


class UserFollowViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.UserFollowSerializer
    queryset = models.UserFollowModule.objects.all()
    permission_classes = (
        permissions.UpdateOwnFollow,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,filters.OrderingFilter,)
    ordering_fields = ['follower__username','following__username','created']
    search_fields = ('follower__username','following__username',)
    http_method_names = ['post','get', 'delete']

    def perform_create(self, serializer):
        serializer.save(follower=self.request.user)


class UserFollowListViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.UserFollowListSerializer
    queryset = models.UserFollowModule.objects.all()
    permission_classes = (
        permissions.UpdateOwnFollow,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,filters.OrderingFilter,)
    ordering_fields = ['following__username','created']
    search_fields = ('following__username',)
    http_method_names = ['get', 'delete']
    lookup_field = 'following'

    def perform_create(self, serializer):
        serializer.save(follower=self.request.user)

    def get_queryset(self):
        final_list = models.UserFollowModule.objects.my_following(follower=self.request.user)
        return final_list


class UserAllDataViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    queryset = models.UserProfile.objects.all()
    serializer_class = serializers.UserAllDataSerializer
    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,filters.OrderingFilter,)
    ordering_fields = ['username','email']
    search_fields = ('username','email',)
    http_method_names = ['get', 'delete']



class UserLoginApiView(ObtainAuthToken):
    renderer_classes = api_settings.DEFAULT_RENDERER_CLASSES
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'name': user.username,
        })



