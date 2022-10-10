from django.urls import path,include
from . import views
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
router.register('register', views.UserRegisterViewSet, 'register')
router.register('picture', views.UserPicViewSet, 'picture')
router.register('username', views.UserNameViewSet, 'username')
router.register('password', views.UserPasswordViewSet, 'password')
router.register('follow', views.UserFollowViewSet, 'follow')
router.register('followlist', views.UserFollowListViewSet, 'followlist')
router.register('all-data', views.UserAllDataViewSet, 'all-data')

urlpatterns = [
    path('login/', views.UserLoginApiView.as_view()),
    path('', include(router.urls))
]