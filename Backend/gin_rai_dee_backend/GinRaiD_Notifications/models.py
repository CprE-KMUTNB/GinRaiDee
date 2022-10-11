from django.db import models
from GinRaiD_UserAPI.models import UserProfile
from GinRaiD_Recipes.models import Menu


class NotificationManager(models.Manager):
    def all_noti(self, *args, **kwargs):
        return super(NotificationManager, self).filter(have_read=False)

    def self_noti(self, *args, **kwargs):
        Receiver = kwargs.pop('Receiver')
        return super(NotificationManager, self).filter(have_read=False, Receiver=Receiver)


class Notification(models.Model):
    Sender = models.ForeignKey(UserProfile, related_name='Sender', on_delete = models.CASCADE)
    Receiver = models.ForeignKey(UserProfile, related_name='Notifications', on_delete = models.CASCADE)
    Information = models.ForeignKey(Menu, related_name='Information', on_delete = models.CASCADE)
    have_read = models.BooleanField(default = False)

    objects = NotificationManager()

    def __str__(self):
        return 'Sender :'+self.Sender.username+' |Recipient :'+self.Receiver.username+' |Data :'+self.Information.Foodname

