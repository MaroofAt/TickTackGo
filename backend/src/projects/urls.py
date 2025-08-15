from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import ProjectViewSet , IssueViewSet

router_user = DefaultRouter()
router_user.register(r'projects' , ProjectViewSet)

router_issue = DefaultRouter()
router_issue.register(r'issues' , IssueViewSet)

urlpatterns = [
    *router_user.urls,
    *router_issue.urls
]
