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
    http_method_names = ['get']

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


class MenuPicViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.MenuPicSerializer
    queryset = models.Menu.objects.all()
    permission_classes = (
        permissions.UpdateOwnMenu,
        IsAuthenticated,
    )
    http_method_names = ['get','put']
    filter_backends = (filters.SearchFilter,)
    search_fields = ('Owner__username',)

    def perform_create(self, serializer):
        serializer.save(Owner=self.request.user)

    def get_queryset(self):
        final_menu_list = models.Menu.objects.owner_menu(Owner=self.request.user)
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
    http_method_names = ['get','put','post','delete']
    def perform_create(self, serializer):
        serializer.save(Owner=self.request.user)

    def get_serializer_class(self):
        if self.action == 'create':
            return serializers.MenuSerializer
        if self.action == 'update':
            return serializers.MenuUpdateSerializer
        return serializers.MenuSerializer
    
    def get_queryset(self):
        final_menu_list = models.Menu.objects.owner_menu(Owner=self.request.user)
        return final_menu_list


class FavoriteViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.FavSerializer
    queryset = models.Favorite.objects.all()
    permission_classes = (
        permissions.UpdateOwnFav,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('fav_menu__Foodname', 'user__username')
    http_method_names = ['get','post','delete']

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class FavoriteListViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    serializer_class = serializers.FavListSerializer
    queryset = models.Favorite.objects.all()
    permission_classes = (
        permissions.UpdateOwnFav,
        IsAuthenticated,
    )
    filter_backends = (filters.SearchFilter,)
    search_fields = ('fav_menu__Foodname', 'user__username')
    lookup_field = 'fav_menu'
    http_method_names = ['get','delete']

    def perform_create(self, serializer):
        serializer.save(Owner=self.request.user)

    def get_queryset(self):
        final_menu_list = models.Favorite.objects.my_fav(user=self.request.user)
        return final_menu_list
