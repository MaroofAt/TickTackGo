from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from .models import User
from .serializers import UserSerializer , RegisterSerializer
from rest_framework import status 
from rest_framework.response import Response


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer


    def get_queryset(self):
        qs = super().get_queryset()

        if not self.request.user.is_staff:
            qs = qs.filter(username = self.request.user.username)

        return qs

    @action(detail=False , methods=['post'] , serializer_class=RegisterSerializer)
    def register(self , request):
        serializer = self.serializer_class(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status = status.HTTP_201_CREATED)
        return Response(serializer.data , status = status.HTTP_400_BAD_REQUEST)
