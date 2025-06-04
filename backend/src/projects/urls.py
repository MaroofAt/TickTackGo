from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import ProjectViewSet

router_user = DefaultRouter()
router_user.register(r'projects' , ProjectViewSet)

urlpatterns = [
    *router_user.urls
]
