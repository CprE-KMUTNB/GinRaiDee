"""gin_rai_dee_backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from django.conf.urls.static import static
from django.conf import settings


urlpatterns = [
    path('admin/', admin.site.urls),
    path('user-api/', include('GinRaiD_UserAPI.urls')),
    path('menu-api/', include('GinRaiD_Recipes.urls')),
    path('notification-api/', include('GinRaiD_Notifications.urls')),
    path('report-api/', include('GinRaiD_Reports.urls'))
] + static(settings.STATIC_URL, document_root = settings.STATIC_ROOT)
