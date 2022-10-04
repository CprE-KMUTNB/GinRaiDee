from django.db import models
from GinRaiD_UserAPI.models import UserProfile


class Menu(models.Model):
    Owner = models.ForeignKey(
        UserProfile,
        on_delete=models.CASCADE,
    )
    Foodname = models.CharField(max_length=255)
    Foodpic = models.URLField()
    ingredient = models.CharField(max_length=255)
    recipes = models.TextField()

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