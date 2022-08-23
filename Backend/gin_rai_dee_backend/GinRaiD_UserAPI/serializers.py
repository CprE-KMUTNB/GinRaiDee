from rest_framework import serializers
from . import models
from rest_framework.exceptions import ValidationError
from rest_framework.permissions import IsAuthenticated


class UserProfileSerializer(serializers.ModelSerializer):
 
    confirm_password = serializers.CharField(write_only=True, style={'input_type': 'password'})

    class Meta:
        model = models.UserProfile
        fields = ('id', 'email', 'username', 'password', 'confirm_password')
        extra_kwargs = {
            'password': {
                'write_only': True,
                'style': {'input_type': 'password'}
            },
        }


    def validate(self, data):
        username_used =  list(models.UserProfile.objects.values_list('username',flat=True))
        email_used = list(models.UserProfile.objects.values_list('email',flat=True))
        email = data.get('email')
        username = data.get('username')
        password = data.get('password')
        confirm_password = data.get('confirm_password')

        Validate_text = {}
        has_error = False

        if email in email_used:
            if not IsAuthenticated:
                Validate_text.update({'email':'This email has been used!'})
                has_error = True
        
        if username in username_used:
            if not IsAuthenticated:
                Validate_text.update({'username' : 'This username has been used!'})
                has_error = True

        if confirm_password != password:
            Validate_text.update({'confirm_password' : 'Password does not match!'})
            has_error = True

        if has_error:
            raise ValidationError(Validate_text)

        return data
        
    
    def create(self, validated_data):
        user = models.UserProfile.objects.create_user(
            email = validated_data['email'],
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