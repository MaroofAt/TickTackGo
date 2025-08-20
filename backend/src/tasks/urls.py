from rest_framework.routers import DefaultRouter

from .views import TaskViewSet , InboxTaskViewSet, TaskDependenciesViewSet

router = DefaultRouter()
router.register(r'tasks' , TaskViewSet)


router2 = DefaultRouter()
router2.register(r'inbox_tasks' , InboxTaskViewSet)


router3 = DefaultRouter()
router3.register(r'tasks-dependencies', TaskDependenciesViewSet)

urlpatterns = [
    *router.urls,
    *router2.urls,
    *router3.urls,
]
