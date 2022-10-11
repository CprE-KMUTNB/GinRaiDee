from django.contrib import admin
from .models import Menu,Favorite

class MenuAdmin(admin.ModelAdmin):
    list_filter = [
        'Owner',
        'Foodname',
        'ingredient',
        'recipes',
    ]

    search_fields = (
        'Owner__username',
        'Foodname',
        'ingredient',
        'recipes',
    )

class FavAdmin(admin.ModelAdmin):
    list_filter = [
        'user',
        'fav_menu',
    ]

    search_fields = (
        'user__username',
        'fav_menu__Foodname',
    )


admin.site.register(Menu,MenuAdmin)
admin.site.register(Favorite,FavAdmin)