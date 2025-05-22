from django.urls import path

from rest_framework.routers import DefaultRouter

from .views import WorkspaceViewSet

router = DefaultRouter()
router.register(r'workspaces' , WorkspaceViewSet)

urlpatterns = [
    *router.urls
]

