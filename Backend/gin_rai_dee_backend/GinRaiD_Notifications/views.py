from django.db.models.signals import post_save
from django.dispatch import receiver
from GinRaiD_Recipes.models import Menu
from .models import Notification
from GinRaiD_UserAPI.models import UserFollowModule,UserProfile
from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework import filters
from rest_framework.permissions import IsAuthenticated
from . import serializers,permissions


@receiver(post_save, sender=Menu)
def notify(sender,instance,**kwargs):
    if instance.is_public == True:
        menu = instance
        sender = instance.Owner
        recipients = list(UserFollowModule.objects.values_list('follower',flat=True).filter(following=sender.id))
        for recipient in recipients:
            receiver = UserProfile.objects.get(pk=recipient)
            Notification.objects.create(Sender = instance.Owner, Receiver = receiver, Information = menu)


class NotificationViewsets(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.NotificationSerializer
    queryset = Notification.objects.all()
    permission_classes = (
        permissions.UpdateOwnNotification,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,filters.OrderingFilter,)
    ordering_fields = ['Sender__username','Information__Foodname','created']
    search_fields = ('Sender__username','Information__Foodname',)
    http_method_names = ['get','put','delete']

    def get_queryset(self):
        if self.request.user:
            self_noti = Notification.objects.self_noti(Receiver=self.request.user)
            final_noti_list = self_noti
        else:
            all_noti = Notification.objects.all_noti()
            final_noti_list = all_noti

        return final_noti_list
