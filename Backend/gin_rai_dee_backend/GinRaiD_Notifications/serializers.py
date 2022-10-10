from rest_framework import serializers
from .models import Notification
from GinRaiD_Recipes.models import Menu
from GinRaiD_Recipes.serializers import MenuSerializer

class NotificationSerializer(serializers.ModelSerializer):

    sender_name = serializers.CharField(source='Sender',read_only=True)
    sender_pic = serializers.ImageField(source='Sender.userpic',read_only=True)
    receiver_name = serializers.CharField(source='Receiver',read_only=True)
    Foodname = serializers.CharField(source='Information.Foodname', read_only=True)
    ingredient = serializers.CharField(source='Information.ingredient', read_only=True)
    recipes = serializers.CharField(source='Information.recipes', read_only=True)
    Foodpic = serializers.ImageField(source='Information.Foodpic',read_only=True)

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
        'have_read')
        extra_kwargs = {
            'Sender': {'read_only': True,},
            'Receiver': {'read_only': True,},
            'Information': {'read_only': True,},
        }