from rest_framework import serializers
from . import models


class ListSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Favorite
        fields = ('id', 'user')
        extra_kwargs = {
            'user': {'read_only': True,},
        }

class FilterMenuListSerializer(serializers.ListSerializer):
    def to_representation(self, data):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
            
        if user:
            private_menu = data.filter(is_public=False, Owner=user)
        else:
            private_menu = data.none()

        public_menu = data.filter(is_public=True)

        final_menu_list = private_menu | public_menu

        return super(FilterMenuListSerializer, self).to_representation(final_menu_list)


class MenuSerializer(serializers.ModelSerializer):

    owner_name = serializers.CharField(source='Owner', read_only = True)
    favorites = ListSerializer(many=True, read_only = True)
    favorites_count = serializers.IntegerField(source='favorites.count', read_only=True)

    class Meta:
        model = models.Menu
        list_serializer_class = FilterMenuListSerializer
        fields = ('id', 'Owner' ,'owner_name' , 'Foodname' , 'Foodpic' , 'ingredient' ,'recipes','favorites','favorites_count' ,'is_public')
        extra_kwargs = {
            'Owner': {'read_only': True,},
        }

class MenuUpdateSerializer(serializers.ModelSerializer):

    owner_name = serializers.CharField(source='Owner', read_only = True)
    favorites = ListSerializer(many=True, read_only = True)
    favorites_count = serializers.IntegerField(source='favorites.count', read_only=True)

    class Meta:
        model = models.Menu
        fields = ('id', 'Owner' ,'owner_name' , 'Foodname' , 'Foodpic' , 'ingredient' ,'recipes','favorites','favorites_count' ,'is_public')
        extra_kwargs = {
            'Owner': {'read_only': True,},
            'Foodpic': {'read_only': True},
        }


class MenuPicSerializer(serializers.ModelSerializer):
    owner_name = serializers.CharField(source='Owner', read_only = True)
    class Meta:
        model = models.Menu
        fields = ('id', 'Owner' ,'owner_name', 'Foodname', 'Foodpic')
        extra_kwargs = {
            'Owner': {'read_only': True,},
            'Foodpic': {'required': True},
            'Foodname': {'read_only': True},
        }



class FavSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Favorite
        fields = ('id', 'user' , 'fav_menu')
        extra_kwargs = {
            'user': {'read_only': True,},
        }


class FavListSerializer(serializers.ModelSerializer):

    Foodname = serializers.CharField(source='fav_menu.Foodname', read_only=True)
    ingredient = serializers.CharField(source='fav_menu.ingredient', read_only=True)
    recipes = serializers.CharField(source='fav_menu.recipes', read_only=True)
    Foodpic = serializers.ImageField(source='fav_menu.Foodpic',read_only=True)

    class Meta:
        model = models.Favorite
        fields = ('id', 'user' , 'fav_menu', 'Foodname','ingredient','recipes','Foodpic')
        extra_kwargs = {
            'user': {'read_only': True,},
            'fav_menu': {'read_only': True,},
        }