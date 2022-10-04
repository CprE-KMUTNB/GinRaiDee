from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework import filters
from rest_framework.permissions import IsAuthenticated
from . import serializers,models,permissions


class MenuViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.MenuSerializer
    queryset = models.Menu.objects.all()
    permission_classes = (
        permissions.UpdateOwnMenu,
        IsAuthenticated
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('Owner__username','Foodname', 'ingredient','recipes')

    def perform_create(self, serializer):
        serializer.save(Owner=self.request.user)
