from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.decorators import action
from rest_framework import status 
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken

from datetime import timedelta

from .models import User , User_OTP
from .serializers import UserSerializer , RegisterSerializer
from django.utils import timezone
from .utils import send_otp_email_to_user



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
    

    @action(detail=False , methods=['post'] ,url_path='send_otp')
    def send_otp(self , request):
        email = request.data.get('email')
        if not email:
            return Response(
                {'error': 'Email is required'},
                status=status.HTTP_400_BAD_REQUEST
            )
        send_otp_email_to_user(email)

        return Response(
            {'message': 'OTP has been sent to your email'},
            status=status.HTTP_200_OK
        )
    
    @action(detail=False , methods=['post'] , serializer_class=RegisterSerializer ,url_path='verify_register')
    def verify_register(self , request):
        email = request.data.get('email')
        otp = request.data.get('otp')
        if not email:
            return Response(
                {'error': 'Email is required'},
                status=status.HTTP_400_BAD_REQUEST
            )
        if not otp:
            return Response(
                {'error': 'OTP is required'},
                status=status.HTTP_400_BAD_REQUEST
            )

        old_otps = User_OTP.objects.filter(expires_at__lt = timezone.now()).delete()
        
        if not User_OTP.objects.filter(otp=otp).exists():
            return Response(
                {'error': 'OTP Does Not Match'},
                status=status.HTTP_406_NOT_ACCEPTABLE
            )
        table_otp = User_OTP.objects.get(otp=otp)
        if table_otp.created_at < timezone.now() - timedelta(minutes=5):
                return Response(status=status.HTTP_410_GONE)
        table_otp.delete()

        serializer = self.serializer_class(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status = status.HTTP_201_CREATED)
        return Response(serializer.data , status = status.HTTP_400_BAD_REQUEST)
    

class GoogleAuthView(APIView):
    permission_classes = [IsAuthenticated]
    def post(request):
        refresh = RefreshToken.for_user(request.user)
        return Response({
            'refresh_token': str(refresh),
            'access_token': str(refresh.access_token)
        }, status.HTTP_202_ACCEPTED)