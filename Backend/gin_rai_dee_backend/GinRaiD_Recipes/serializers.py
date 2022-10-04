from rest_framework import serializers
from . import models


class MenuSerializer(serializers.ModelSerializer):

    owner = serializers.CharField(source='Owner', read_only = True)
    class Meta:
        model = models.Menu
        fields = ('id', 'owner' , 'Foodname' , 'Foodpic' , 'ingredient' ,'recipes', 'is_public')
        extra_kwargs = {
            'is_public': {
                'write_only': True,
            },
        }