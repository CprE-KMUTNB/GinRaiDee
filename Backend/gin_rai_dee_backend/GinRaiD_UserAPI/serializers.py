from rest_framework import serializers
from . import models
from rest_framework.exceptions import ValidationError
from GinRaiD_Recipes.serializers import MenuSerializer,FavListSerializer
from GinRaiD_Notifications.serializers import NotificationSerializer


class UserRegisterSerializer(serializers.ModelSerializer):
 
    confirm_password = serializers.CharField(write_only=True, style={'input_type': 'password'})

    class Meta:
        model = models.UserProfile
        fields = ('id', 'email', 'username','userslug', 'password', 'confirm_password')
        extra_kwargs = {
            'password': {
                'write_only': True,
                'style': {'input_type': 'password'}
            },
            'userslug': {'read_only':True},
        }


    def validate(self,data):
        email_used = list(models.UserProfile.objects.values_list('email',flat=True))
        email = data.get('email').lower()
        username = data.get('username')
        password = data.get('password')
        confirm_password = data.get('confirm_password')
        restrict_sign = '\\'



        Validate_text = {}
        has_error = False

        if email.lower() in email_used:
            Validate_text.update({'email':'This email has been used!'})
            has_error = True

        if restrict_sign in email:
            Validate_text.update({'email': 'Can not use special character'})
            has_error = True

        if restrict_sign in username:
            Validate_text.update({'username': 'Can not use special character'})
            has_error = True
        
        if len(username.split(' ')) != 1:
            Validate_text.update({'username' : 'Can not use space in username'})
            has_error = True

        if confirm_password != password:
            Validate_text.update({'confirm_password' : 'Password does not match!'})
            has_error = True
        
        if restrict_sign in password:
            Validate_text.update({'password': 'Can not use special character'})
            has_error = True

        if has_error:
            raise ValidationError(Validate_text)

        return data
        
    
    def create(self, validated_data):
        user = models.UserProfile.objects.create_user(
            email = validated_data['email'].lower(),
            username = validated_data['username'],
            password = validated_data['password'],
        )

        return user

    def update(self, instance, validated_data):
        password = validated_data['password'],
        if 'password' in validated_data:
            password = validated_data.pop('password')
            instance.set_password(password)
        return super().update(instance, validated_data)


class UserPicSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.UserProfile
        fields = ('id', 'username','userpic')
        extra_kwargs = {
            'username': {'read_only':True},
        }


class UserNameSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.UserProfile
        fields = ('id', 'username')

    def validate(self,data):
        username = data.get('username')
        restrict_sign = '\\'

        Validate_text = {}
        has_error = False

        if restrict_sign in username:
            Validate_text.update({'username': 'Can not use special character'})
            has_error = True
        
        if len(username.split(' ')) != 1:
            Validate_text.update({'username' : 'Can not use space in username'})
            has_error = True

        if has_error:
            raise ValidationError(Validate_text)

        return data


class PasswordSerializer(serializers.ModelSerializer):
    old_password = serializers.CharField(write_only=True, style={'input_type': 'password'})
    confirm_password = serializers.CharField(write_only=True, style={'input_type': 'password'})

    class Meta:
        model = models.UserProfile
        fields = ('id', 'old_password' ,'password', 'confirm_password')
        extra_kwargs = {
            'password': {
                'write_only': True,
                'style': {'input_type': 'password'}
            },}

    def validate(self,data):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        old_password = data.get('old_password')
        password = data.get('password')
        confirm_password = data.get('confirm_password')
        Validate_text = {}
        has_error = False

        if not user.check_password(old_password):
            Validate_text.update({'old_password' : 'Incorrect Password!'})
            has_error = True

        if confirm_password != password:
            Validate_text.update({'confirm_password' : 'Password does not match!'})
            has_error = True

        if has_error:
            raise ValidationError(Validate_text)

        return data

    def update(self, instance, validated_data):
        password = validated_data['password'],
        if 'password' in validated_data:
            password = validated_data.pop('password')
            instance.set_password(password)
        return super().update(instance, validated_data)



class UserFollowSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.UserFollowModule
        fields = ('id','follower','following','created')
        extra_kwargs = {
            'follower': {'read_only':True},
            'created': {'read_only':True},
        }
    

class UserFollowListSerializer(serializers.ModelSerializer):

    followingname = serializers.CharField(source = 'following.username', read_only=True)
    followingpic = serializers.ImageField(source = 'following.userpic', read_only=True)
    
    class Meta:
        model = models.UserFollowModule
        fields = ('following','followingname','followingpic','created')
        extra_kwargs = {
            'created': {'read_only':True},
        }


class FollowerSerializer(serializers.ModelSerializer):
    followername = serializers.CharField(source = 'follower.username', read_only=True)
    followerpic = serializers.ImageField(source = 'follower.userpic', read_only=True)
    
    class Meta:
        model = models.UserFollowModule
        fields = ('follower','followername','followerpic','created')
        extra_kwargs = {
            'created': {'read_only':True},
        }

    

class UserAllDataSerializer(serializers.ModelSerializer):

    is_follow = serializers.SerializerMethodField()
    menu = MenuSerializer(many=True, read_only=True)
    favorite = FavListSerializer(many=True, read_only=True)
    following = UserFollowListSerializer(many=True, read_only=True)
    following_count = serializers.IntegerField(source='following.count', read_only=True)
    follower = FollowerSerializer(many=True, read_only=True)
    follower_count = serializers.IntegerField(source='follower.count', read_only=True)
    Notifications = NotificationSerializer(many=True, read_only=True)

    class Meta:
        model = models.UserProfile
        fields = ('id', 'email', 'username','userpic', 'is_follow' ,'menu', 'favorite', 'follower','follower_count' ,'following', 'following_count','Notifications') 

    def get_is_follow(self,obj):
        user = None
        request = self.context.get("request")
        if request and hasattr(request, "user"):
            user = request.user
        following = list(models.UserFollowModule.objects.values_list('following',flat=True).filter(follower=user.id))
        if obj.id in following:
            return True
        return False