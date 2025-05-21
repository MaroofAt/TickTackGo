
import pyotp
from datetime import datetime, timedelta
from django.core.mail import send_mail
from django.conf import settings



def generate_otp():
    # TODO if we want to use pyotp package to generate the OTP
    totp = pyotp.TOTP(pyotp.random_base32(), interval=300)  # 5 minutes validity
    return totp.now()


def send_otp_email(user):
    otp = generate_otp()
    otp_expiry = datetime.now() + timedelta(minutes=5) 

    user.otp = otp
    # user.otp_created_at = datetime.now()
    user.save()

    subject = 'Email Verification OTP'
    message = f'Your OTP for email verification is: {otp}\nThis OTP is valid for 5 minutes.'
    email_from = settings.DEFAULT_FROM_EMAIL
    recipient_list = [user.email]

    # email_from = settings.EMAIL_HOST_USER

    send_mail(subject, message,email_from, recipient_list , fail_silently=False)
