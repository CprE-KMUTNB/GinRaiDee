from rest_framework import permissions

class UpdateOwnMenu(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.Owner.id == request.user.id

class UpdateOwnFav(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.user.id == request.user.id
