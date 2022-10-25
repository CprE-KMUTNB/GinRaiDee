from django.db import models
from GinRaiD_UserAPI.models import UserProfile
import os
import uuid


def image_file_path(instance, filename):
    ext = os.path.splitext(filename)[1]
    filename = f'{uuid.uuid4()}{ext}'
    return os.path.join('media','images', filename)


class MenuManager(models.Manager):
    def public_menu(self, *args, **kwargs):
        return super(MenuManager, self).filter(is_public=True)

    def private_menu(self, *args, **kwargs):
        Owner = kwargs.pop('Owner')
        return super(MenuManager, self).filter(is_public=False, Owner=Owner)

    def owner_menu(self, *args, **kwargs):
        Owner = kwargs.pop('Owner')
        return super(MenuManager, self).filter(Owner=Owner)



class Menu(models.Model):
    Owner = models.ForeignKey(
        UserProfile,
        on_delete=models.CASCADE,
        related_name = 'menu'
    )
    Foodname = models.CharField(max_length=255)
    Foodpic = models.ImageField(upload_to = image_file_path,null = True)
    ingredient = models.TextField()
    recipes = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    is_public = models.BooleanField(default=True)

    objects = MenuManager()

    def __str__(self):
        return self.Foodname
    
    def __unicode__(self):
        return self.Foodname
    
    def get_pic(self):
        return self.Foodpic

    def get_owner(self):
        return self.Owner

    def get_recipe(self):
        return self.recipes

    def get_ingredient(self):
        return self.ingredient



class FavManager(models.Manager):
    def my_fav(self, *args, **kwargs):
        user = kwargs.pop('user')
        return super(FavManager, self).filter(user=user)


class Favorite(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE,related_name = 'favorite')
    fav_menu = models.ForeignKey(Menu, on_delete=models.CASCADE,related_name = 'favorites')
    created = models.DateTimeField(auto_now_add=True)

    objects = FavManager()

    class Meta:
        unique_together = ('user', 'fav_menu',)
        # db_table = 'favorite'

    def __str__(self):
        return 'user :'+self.user.username+' |favorite :'+self.fav_menu.Foodname
