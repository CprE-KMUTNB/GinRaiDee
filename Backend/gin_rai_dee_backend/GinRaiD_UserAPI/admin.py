from django.contrib import admin
from .models import UserProfile
from GinRaiD_Recipes.models import Menu

admin.site.register(UserProfile)
admin.site.register(Menu)
