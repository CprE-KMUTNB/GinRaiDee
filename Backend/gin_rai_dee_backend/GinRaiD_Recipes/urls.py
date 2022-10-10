from django.urls import path,include
from . import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('all', views.MenuViewSet,'all')
router.register('pic', views.MenuPicViewSet,'pic')
router.register('self', views.SelfViewSet,'self')
router.register('favorite', views.FavoriteViewSet,'favorite')
router.register('fav-list', views.FavoriteListViewSet, 'fav-list')


urlpatterns = [
    path('', include(router.urls))
]