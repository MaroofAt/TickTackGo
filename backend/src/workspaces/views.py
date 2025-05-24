from django.shortcuts import render

from rest_framework import viewsets , status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from .models import Workspace
from .serializers import WorkspaceSerializer

# Create your views here.
class WorkspaceViewSet(viewsets.ModelViewSet):
    queryset = Workspace.objects.all()
    serializer_class = WorkspaceSerializer
    permission_classes = [IsAuthenticated]

    def get_permissions(self):
        
        return super().get_permissions()


    def create(self, request, *args, **kwargs):
        return super().create(request, *args, **kwargs)
    def update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return Response(
            {"detail": "Method not allowed"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )
        return super().update(request, *args, **kwargs)
    def partial_update(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return Response(
            {"detail": "Method not allowed"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )
        return super().partial_update(request, *args, **kwargs)
    def list(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return Response(
            {"detail": "Method not allowed"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )
        return super().list(request, *args, **kwargs)
    def retrieve(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return Response(
            {"detail": "Method not allowed"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )
        return super().retrieve(request, *args, **kwargs)
    def destroy(self, request, *args, **kwargs): # NOT ALLOWED! #TODO STILL_NOT_ALLOWED
        return Response(
            {"detail": "Method not allowed"},
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )
        return super().destroy(request, *args, **kwargs)