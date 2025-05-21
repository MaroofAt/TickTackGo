from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import UserViewSet

router_user = DefaultRouter()
router_user.register(r'users' , UserViewSet)

urlpatterns = [
    *router_user.urls
]
