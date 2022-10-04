from django.db import models
from GinRaiD_UserAPI.models import UserProfile


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
    )
    Foodname = models.CharField(max_length=255)
    Foodpic = models.URLField(max_length=255)
    ingredient = models.CharField(max_length=255)
    recipes = models.TextField()
    is_public = models.BooleanField()

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
