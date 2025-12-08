from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.db import transaction
from django.core.exceptions import ValidationError
from social_django.models import UserSocialAuth

from .models import User , Device


class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    email = serializers.EmailField(required=True)
    password = serializers.CharField(write_only=True,required=True,style={'input_type': 'password'})
    device_id = serializers.CharField(required=True)
    device_type = serializers.CharField(required=True)
    
    def validate(self, attrs):
        device_id = attrs.get('device_id' , None)
        if not device_id:
            raise ValidationError({'detail': 'device_id is required in login!!!'})
        device_type = attrs.get('device_type' , None)
        if not device_type:
            raise ValidationError({'detail': 'device_type is required in login!!!'})
        return super().validate(attrs)
    
    

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'username',
            'email',
            'image',
            'created_at',
            'updated_at'
        ]
        extra_kwargs = {
            'image': {'required': False},
            'email': {'read_only': True},
            'username': {'required': True}
        }


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True,required=True,style={'input_type': 'password'})
    

    class Meta:
        model = User
        fields = ['username', 'email' , 'password' , 'how_to_use_website' , 'what_do_you_do' , 'how_did_you_get_here']
        extra_kwargs = {
            'username': {'required': True},
            'email': {'required': True},
        }

    def validate(self, attrs):
        try:
            if not attrs['password']:  # Check for empty string/None
                raise serializers.ValidationError({
                    'password': 'This field may not be blank (empty).'
                })
        except KeyError:
            raise serializers.ValidationError({
                'password': 'This field is required.'
            })
        
        attrs = super().validate(attrs) 

        if len(attrs['password']) < 8:
            raise serializers.ValidationError({'password': 'must be 8 characters or more'})

        return attrs

    def create(self, validated_data):
        try:
            with transaction.atomic():
                user = User.objects.create_user(
                    username = validated_data['username'],
                    email = validated_data['email'],
                    password = validated_data['password'],
                    how_to_use_website = validated_data['how_to_use_website'],
                    what_do_you_do = validated_data['what_do_you_do'],
                    how_did_you_get_here = validated_data['how_did_you_get_here'],
                )

                # for social-auth providers table
                UserSocialAuth.objects.create(user=user, provider='email', uid=validated_data['email'])

                # send_otp_email(user)


                # TODO if we want to create Default workspace when the user Register

                # default_workspace = Workspace.objects.create(
                #     name="Default Workspace",
                #     image=None, #TODO put a default workspace-image path
                #     owner=user
                # )

                # Users_Workspaces.objects.create(
                #     user=user,
                #     workspace=default_workspace,
                #     user_role='owner'
                # )


            return user
        except KeyError as e:
            raise serializers.ValidationError(f'{str(e)}: this field is required !')
 


class DeviceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Device
        fields = ['registration_id', 'device_type' , 'user']
        extra_kwargs = {
            'registration_id': {'required': True},
            'device_type': {'required': False},
            'user': {'required': True}
        }

class NotificationSerializer(serializers.Serializer):
    title = serializers.CharField(max_length=255)
    body = serializers.CharField(max_length=1024)
    data = serializers.DictField(required=False)
