from rest_framework import serializers
from . import models
from GinRaiD_UserAPI.models import UserFollowModule
from rest_framework.exceptions import ValidationError


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
 
    is_following = serializers.SerializerMethodField()
    owner_name = serializers.CharField(source='Owner', read_only = True)
    owner_pic = serializers.ImageField(source='Owner.userpic', read_only = True)
    is_favorites = serializers.SerializerMethodField()
    favorites = ListSerializer(many=True, read_only = True)
    favorites_count = serializers.IntegerField(source='favorites.count', read_only=True)

    class Meta:
        model = models.Menu
        list_serializer_class = FilterMenuListSerializer
        fields = ('id', 'Owner' ,'owner_name', 'owner_pic', 'is_following' ,'Foodname' , 'Foodpic' , 'ingredient' ,'recipes', 'is_favorites' ,'favorites','favorites_count' ,'is_public', 'created')
        extra_kwargs = {
            'Owner': {'read_only': True,},
            'created': {'read_only': True,},
        }

    def get_is_following(self,obj):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        following = list(UserFollowModule.objects.values_list('following',flat=True).filter(follower=user.id))
        if obj.Owner.id in following:
            return True
        return False

    def validate(self, data):
        pic = data.get('Foodpic')
        Validate_text = {}
        has_error = False

        if pic is None:
            Validate_text.update({'Foodpic' : 'This field cannot be blank!'})
            has_error = True

        if has_error:
            raise ValidationError(Validate_text)

        return data



    def get_is_favorites(self,obj):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        fav_list = list(models.Favorite.objects.values_list('user',flat=True).filter(fav_menu=obj.id))
        if user.id in fav_list:
            return True
        return False


class MenuUpdateSerializer(serializers.ModelSerializer):

    owner_name = serializers.CharField(source='Owner', read_only = True)
    favorites = ListSerializer(many=True, read_only = True)
    favorites_count = serializers.IntegerField(source='favorites.count', read_only=True)

    class Meta:
        model = models.Menu
        fields = ('id', 'Owner' ,'owner_name' , 'Foodname' , 'Foodpic' , 'ingredient' ,'recipes','favorites','favorites_count' ,'is_public','created')
        extra_kwargs = {
            'Owner': {'read_only': True,},
            'Foodpic': {'read_only': True},
            'created': {'read_only': True,},
        }


class MenuPicSerializer(serializers.ModelSerializer):
    owner_name = serializers.CharField(source='Owner', read_only = True)
    class Meta:
        model = models.Menu
        fields = ('id', 'Owner' ,'owner_name', 'Foodname', 'Foodpic','created')
        extra_kwargs = {
            'Owner': {'read_only': True,},
            'Foodpic': {'required': True},
            'Foodname': {'read_only': True},
            'created': {'read_only': True,},
        }
    def validate(self, data):
        pic = data.get('Foodpic')
        Validate_text = {}
        has_error = False

        if pic is None:
            Validate_text.update({'Foodpic' : 'This field cannot be blank!'})
            has_error = True

        if has_error:
            raise ValidationError(Validate_text)

        return data


class FavSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Favorite
        fields = ('id', 'user' , 'fav_menu','created')
        extra_kwargs = {
            'user': {'read_only': True,},
            'created': {'read_only': True,},
        }
    def validate(self,data):
        menu = data.get('fav_menu')
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        menus = list(models.Favorite.objects.values_list('fav_menu',flat=True).filter(user=user.id))
        if menu.id in menus:
            raise ValidationError({'fav_menu':'This menu has been favorited!'})
        return data   
        


class FavListSerializer(serializers.ModelSerializer):

    is_following = serializers.SerializerMethodField()
    owner_id = serializers.IntegerField(source='fav_menu.Owner.id', read_only=True)
    owner_name = serializers.CharField(source='fav_menu.Owner', read_only = True)
    owner_pic = serializers.ImageField(source='fav_menu.Owner.userpic', read_only = True)
    Foodname = serializers.CharField(source='fav_menu.Foodname', read_only=True)
    ingredient = serializers.CharField(source='fav_menu.ingredient', read_only=True)
    recipes = serializers.CharField(source='fav_menu.recipes', read_only=True)
    Foodpic = serializers.ImageField(source='fav_menu.Foodpic',read_only=True)
    is_favorites = serializers.SerializerMethodField()
    favorites_count = serializers.IntegerField(source='fav_menu.favorites.count', read_only=True)

    class Meta:
        model = models.Favorite
        fields = ('fav_menu','user','owner_id','owner_name','owner_pic', 'Foodname','ingredient','recipes','Foodpic','is_following','is_favorites','favorites_count','created')
        extra_kwargs = {
            'user': {'read_only': True,},
            'fav_menu': {'read_only': True,},
            'created': {'read_only': True,},
        }
    
    def get_is_following(self,obj):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        following = list(UserFollowModule.objects.values_list('following',flat=True).filter(follower=user.id))
        if obj.fav_menu.Owner.id in following:
            return True
        return False

    def get_is_favorites(self,obj):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        fav_list = list(models.Favorite.objects.values_list('user',flat=True).filter(fav_menu=obj.fav_menu.id))
        if user.id in fav_list:
            return True
        return False