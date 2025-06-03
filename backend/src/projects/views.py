from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from .models import Project

# Create your views here.
class ProjectViewSet(viewsets.ModelViewSet):
    queryset = Project.objects.all()
    serializer_class = None #TODO
    permission_classes = [IsAuthenticated]
    