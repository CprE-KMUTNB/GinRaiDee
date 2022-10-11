from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework import filters
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.settings import api_settings
from rest_framework.permissions import IsAuthenticated
from . import serializers,models,permissions


class UserRegisterViewSet(viewsets.ModelViewSet):
    serializer_class = serializers.UserRegisterSerializer
    queryset = models.UserProfile.objects.all()
    authentication_classes = (TokenAuthentication,)
    permission_classes = (permissions.UpdateOwnProfile,)
    filter_backends = (filters.SearchFilter,)
    search_fields = ('username', 'email',)
    http_method_names = ['post']

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
    filter_backends = (filters.SearchFilter,)
    search_fields = ('username')


class UserNameViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.UserNameSerializer
    queryset = models.UserProfile.objects.all()
    http_method_names = ['get','put', ]
    permission_classes = (
        permissions.UpdateOwnProfile,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('username')


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
    search_fields = ('username')
    
    


class UserFollowViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.UserFollowSerializer
    queryset = models.UserFollowModule.objects.all()
    permission_classes = (
        permissions.UpdateOwnFollow,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('follower__username','following__username')
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
    filter_backends = (filters.SearchFilter,)
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
    filter_backends = (filters.SearchFilter,)
    search_fields = ('username','email')
    http_method_names = ['get', 'delete']



class UserLoginApiView(ObtainAuthToken):
    renderer_classes = api_settings.DEFAULT_RENDERER_CLASSES
