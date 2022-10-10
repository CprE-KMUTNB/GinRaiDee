import os
import uuid
from django.db import models
from django.contrib.auth.models import AbstractBaseUser,PermissionsMixin,BaseUserManager
from django.template.defaultfilters import slugify


class UserProfileManager(BaseUserManager):
    
    def create_user(self, email, username, password=None):
        if not email:
            raise ValueError('Please put your email address')
        
        email = self.normalize_email(email)
        user = self.model(email=email, username=username)

        user.set_password(password)
        user.save(using=self._db)

        return user
    
    def create_superuser(self, email, username, password):
        user = self.create_user(email, username, password)

        user.is_superuser = True
        user.is_staff = True
        user.save(using=self._db)

        return user


def image_file_path(instance, filename):
    ext = os.path.splitext(filename)[1]
    filename = f'{uuid.uuid4()}{ext}'
    return os.path.join('static','profile-images', filename)



class UserProfile(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(max_length=255, unique=True)
    username = models.CharField(max_length=255, unique=True)
    userslug = models.SlugField()
    userpic = models.ImageField(upload_to = image_file_path, null = True)
    is_activate = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UserProfileManager()


    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def save(self, *args, **kwargs):
        if not self.id:
            self.userslug = slugify(self.username)

        super(UserProfile, self).save(*args, **kwargs)


    def get_email(self):
        return self.email
    
    def __str__(self):
        return self.username


class UserFollowManager(models.Manager):
    def my_following(self, *args, **kwargs):
        user = kwargs.pop('follower')
        return super(UserFollowManager, self).filter(follower=user)
        

class UserFollowModule(models.Model):
    follower = models.ForeignKey(UserProfile, related_name='following', on_delete=models.CASCADE)
    following = models.ForeignKey(UserProfile, related_name='follower', on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)

    objects = UserFollowManager()

    class Meta:
        unique_together = ('follower', 'following',)