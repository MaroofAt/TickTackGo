from rest_framework.routers import DefaultRouter

from .views import TaskViewSet , InboxTaskViewSet

router = DefaultRouter()
router.register(r'tasks' , TaskViewSet)

router2 = DefaultRouter()
router2.register(r'inbox_tasks' , InboxTaskViewSet)


urlpatterns = [
    *router.urls,
    *router2.urls,
]
