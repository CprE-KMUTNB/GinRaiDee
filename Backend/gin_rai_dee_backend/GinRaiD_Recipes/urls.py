from django.urls import path,include
from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('menu-self', views.SelfViewSet, 'menu-self')
router.register('menu-owner', views.MenuOwnerViewSet, 'menu-owner')
router.register('menu-all', views.MenuViewSet, 'menu-all')

urlpatterns = [
    path('', include(router.urls)),
]
