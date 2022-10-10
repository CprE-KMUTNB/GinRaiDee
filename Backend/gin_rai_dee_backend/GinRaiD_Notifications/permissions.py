from rest_framework import permissions


class UpdateOwnNotification(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.Receiver.id == request.user.id

