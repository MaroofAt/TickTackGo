from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from .models import User
from .serializers import UserSerializer , RegisterSerializer
from rest_framework import status 
from rest_framework.response import Response
from django.utils import timezone
from datetime import timedelta



class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer


    def get_queryset(self):
        qs = super().get_queryset()

        if not self.request.user.is_staff:
            qs = qs.filter(username = self.request.user.username)

        return qs

    @action(detail=False , methods=['post'] , serializer_class=RegisterSerializer , url_path='register')
    def register(self , request):
        serializer = self.serializer_class(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status = status.HTTP_201_CREATED)
        return Response(serializer.data , status = status.HTTP_400_BAD_REQUEST)
    
    @action(detail=False , methods=['post'] , url_path='verify_otp')
    def verify_otp(self , request):
        email = request.data.get('email')
        otp = request.data.get('otp')
        try:
            user = User.objects.get(email = email)
            print(user.otp_created_at)
            if user.otp_created_at < timezone.now() - timedelta(minutes=5):
                return Response(status=status.HTTP_410_GONE)
            
            if user.otp == otp: 
                user.is_email_verified = True
                user.otp = None 
                user.save()
                return Response(status=status.HTTP_202_ACCEPTED)
        except Exception as e:
            return Response(
                {"message": e}, 
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )