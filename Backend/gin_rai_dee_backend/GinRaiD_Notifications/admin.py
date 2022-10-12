from django.contrib import admin
from .models import Notification

class NotificationAdmin(admin.ModelAdmin):
    list_filter = [
        'Sender',
        'Receiver',
        'Information',
        'created'
    ]

    search_fields = (
        'Sender__username',
        'Receiver__username',
        'Information__Foodname'
    )


admin.site.register(Notification, NotificationAdmin)

