from django.contrib import admin
from .models import UserProfile,UserFollowModule

class UserAdmin(admin.ModelAdmin):
    list_filter = [
        'email',
        'username',
        'is_activate',
    ]

    search_fields = (
        'email',
        'username',
    )

class FollowAdmin(admin.ModelAdmin):
    list_filter = [
        'follower',
        'following',
        'created',
    ]

    search_fields = (
        'follower__username',
        'following__username',
    )


admin.site.register(UserProfile,UserAdmin)
admin.site.register(UserFollowModule,FollowAdmin)
