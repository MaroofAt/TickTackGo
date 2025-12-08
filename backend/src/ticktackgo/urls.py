"""
URL configuration for ticktackgo project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
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
import os
from django.contrib import admin
from django.urls import path , include
from django.conf import settings
from django.conf.urls.static import static

from rest_framework_simplejwt.views import TokenObtainPairView , TokenRefreshView
from users.views import CustomTokenObtainPairView
from drf_spectacular.views import SpectacularAPIView, SpectacularSwaggerView
from drf_spectacular.utils import extend_schema , extend_schema_view
from django.views.static import serve

from users.views import GoogleAuthView
from workspaces.views import WorkspaceViewSet

api_patterns = [
    path('users/token/' , extend_schema_view(
        post=extend_schema(
            tags=['Users/Auth'],
            summary="Token",
            request={
                'application/json':{
                    'type':'object',
                    'properties':{
                        'email':{'type':'string', 'example':'m@m.com'},
                        'password':{'type':'string', 'example':'12345678'},
                        'device_id': {'type':'string', 'example':'The FCM Token'},
                        'device_type': {'type':'string', 'example':'Android'}
                    }
                }
            }
        ))(CustomTokenObtainPairView.as_view()) , name='token_obtain_pair'),
    path('users/token/refresh/' , extend_schema_view(post=extend_schema(tags=['Users/Auth'], summary="Refresh Token"))(TokenRefreshView.as_view()) , name='token_refresh'),
    path('' , include('users.urls') ),
    path('' , include('workspaces.urls') ),
    path('' , include('projects.urls') ),
    path('' , include('tasks.urls') ),
]

urlpatterns = [
    # path('admin/', admin.site.urls),
    path('auth/' , include('social_django.urls', namespace='social')),
    path('auth/success/' , GoogleAuthView.as_view() , name='google_auth_view'),
    path('api/' , include(api_patterns)),
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    path('api/docs/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    path('__depug__/',include('debug_toolbar.urls')),
    path('.well-known/assetlinks.json', 
         serve, 
         {'path': 'assetlinks.json', 'document_root': os.path.join(settings.BASE_DIR, '.well-known')},
         name='asset_links'),
    path('invite-link/<str:token>/join-us' , WorkspaceViewSet.as_view({'get': 'list'}) , name='workspace_invitation'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)