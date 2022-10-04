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
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('Owner__username','Foodname', 'ingredient','recipes')

    def perform_create(self, serializer):
        serializer.save(Owner=self.request.user)
    
    def get_queryset(self):
        if self.request.user:
            private_menu = models.Menu.objects.private_menu(Owner=self.request.user)
        else:
            private_menu = models.Menu.objects.none()

        public_menu = models.Menu.objects.public_menu()

        final_menu_list = private_menu | public_menu

        return final_menu_list

class MenuOwnerViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.MenuSerializer
    queryset = models.Menu.objects.all()
    permission_classes = (
        permissions.UpdateOwnMenu,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('=Owner__username',)

    def perform_create(self, serializer):
        serializer.save(Owner=self.request.user)
    
    def get_queryset(self):
        if self.request.user:
            private_menu = models.Menu.objects.private_menu(Owner=self.request.user)
        else:
            private_menu = models.Menu.objects.none()

        public_menu = models.Menu.objects.public_menu()

        final_menu_list = private_menu | public_menu

        return final_menu_list

class SelfViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.MenuSerializer
    queryset = models.Menu.objects.all()
    permission_classes = (
        permissions.UpdateOwnMenu,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('Foodname', 'ingredient','recipes')

    def perform_create(self, serializer):
        serializer.save(Owner=self.request.user)
    
    def get_queryset(self):
        final_menu_list = models.Menu.objects.owner_menu(Owner=self.request.user)
        return final_menu_list
