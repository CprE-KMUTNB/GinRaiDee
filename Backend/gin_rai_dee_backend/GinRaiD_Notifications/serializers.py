from rest_framework import serializers
from .models import Notification
from GinRaiD_Recipes.models import Menu,Favorite
from GinRaiD_Recipes.serializers import MenuSerializer
from GinRaiD_UserAPI.models import UserFollowModule

class NotificationSerializer(serializers.ModelSerializer):

    sender_name = serializers.CharField(source='Sender',read_only=True)
    sender_pic = serializers.ImageField(source='Sender.userpic',read_only=True)
    receiver_name = serializers.CharField(source='Receiver',read_only=True)
    Foodname = serializers.CharField(source='Information.Foodname', read_only=True)
    ingredient = serializers.CharField(source='Information.ingredient', read_only=True)
    recipes = serializers.CharField(source='Information.recipes', read_only=True)
    Foodpic = serializers.ImageField(source='Information.Foodpic',read_only=True)
    is_following = serializers.SerializerMethodField()
    is_favorites = serializers.SerializerMethodField()
    favorites_count = serializers.IntegerField(source='Information.favorites.count', read_only=True)

    class Meta:
        model = Notification
        fields = (
            'id', 
        'Sender', 
        'sender_name',
        'sender_pic', 
        'Receiver' ,
        'receiver_name', 
        'Information', 
        'Foodname',
        'ingredient',
        'recipes',
        'Foodpic',
        'created',
         'is_following',
         'is_favorites',
         'favorites_count',
        'have_read')
        extra_kwargs = {
            'Sender': {'read_only': True,},
            'Receiver': {'read_only': True,},
            'Information': {'read_only': True,},
        }

    def get_is_following(self,obj):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        following = list(UserFollowModule.objects.values_list('following',flat=True).filter(follower=user.id))
        if obj.Information.Owner.id in following:
            return True
        return False

    def get_is_favorites(self,obj):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        fav_list = list(Favorite.objects.values_list('user',flat=True).filter(fav_menu=obj.Information.id))
        if user.id in fav_list:
            return True
        return False