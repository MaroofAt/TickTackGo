from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from .models import User , user_otp
from .serializers import UserSerializer , RegisterSerializer
from rest_framework import status 
from rest_framework.response import Response
from django.utils import timezone
from datetime import timedelta
from .utils import send_otp_email , send_otp_email_to_user



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
    
    # @action(detail=False , methods=['post'] , url_path='verify_otp')
    # def verify_otp(self , request):
    #     email = request.data.get('email')
    #     otp = request.data.get('otp')
    #     if not email:
    #         return Response(
    #             {'error': 'Email is required'},
    #             status=status.HTTP_400_BAD_REQUEST
    #         )
    #     if not otp:
    #         return Response(
    #             {'error': 'OTP is required'},
    #             status=status.HTTP_400_BAD_REQUEST
    #         )
        
    #     try:
    #         user = User.objects.get(email = email)
    #         # print(user.otp_created_at)
    #         if user.otp_created_at < timezone.now() - timedelta(minutes=5):
    #             return Response(status=status.HTTP_410_GONE)
            
    #         if user.otp == otp: 
    #             user.is_email_verified = True
    #             user.otp = None 
    #             user.save()
    #             return Response(status=status.HTTP_202_ACCEPTED)
    #     except Exception as e:
    #         return Response(
    #             {"message": e}, 
    #             status=status.HTTP_500_INTERNAL_SERVER_ERROR
    #         )
    
    # @action(detail=False , methods=['post'] , url_path='resend_otp')
    # def resend_otp(self , request):
    #     email = request.data.get('email')
    #     if not email:
    #         return Response(
    #             {'error': 'Email is required'},
    #             status=status.HTTP_400_BAD_REQUEST
    #         )
    #     user = User.objects.get(email=email)

    #     if user.is_email_verified:
    #         return Response(
    #             {'message': 'This Email is already verified !!'},
    #             status=status.HTTP_306_RESERVED
    #         )


    #     # TODO to prevent the user send for another otp until the previous one end 
    #     if user.otp_created_at and (timezone.now() - user.otp_created_at) < timedelta(minutes=5):
    #         return Response(
    #             {'error': 'Please wait before requesting another OTP'},
    #             status=status.HTTP_429_TOO_MANY_REQUESTS
    #         )

    #     send_otp_email(user)

    #     return Response(
    #         {'message': 'New OTP has been sent to your email'},
    #         status=status.HTTP_200_OK
    #     )
        


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


        if not user_otp.objects.filter(otp=otp).exists():
            return Response(
                {'error': 'OTP Does Not Match'},
                status=status.HTTP_406_NOT_ACCEPTABLE
            )
        table_otp = user_otp.objects.get(otp=otp)
        if table_otp.created_at < timezone.now() - timedelta(minutes=5):
                return Response(status=status.HTTP_410_GONE)
        table_otp.verified = True
        table_otp.delete()

        serializer = self.serializer_class(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data , status = status.HTTP_201_CREATED)
        return Response(serializer.data , status = status.HTTP_400_BAD_REQUEST)