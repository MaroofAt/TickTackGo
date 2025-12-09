
from django.conf import settings
from users.models import User , Device
import requests , os
import json
from google.oauth2 import service_account


class NotificationService:
    def __init__(self):
        self.access_token = self._get_access_token()
    

    def _get_access_token(self):
        """Get OAuth2 access token using service account"""
        try:
            
            credentials = service_account.Credentials.from_service_account_file(
                # os.path.join(settings.BASE_DIR, 'config', 'taskmanagment-ab14e-firebase-adminsdk-fbsvc-956ece5f7c.json'),
                settings.SERVICE_ACCOUNT_FILE,
                scopes=['https://www.googleapis.com/auth/firebase.messaging']
            )
            credentials = credentials.with_scopes(['https://www.googleapis.com/auth/firebase.messaging'])
            access_token_info = credentials.get_access_token()
            return access_token_info.token
        except Exception as e:
            print(f"Error getting access token: {e}")
            return None


    def send_to_user(self , user_id , title , body , data=None):
        try:
            user = User.objects.get(id=user_id)
            devices = Device.objects.filter(user=user, active=True)
            
            if not devices.exists():
                return {"success": False, "message": "No active devices found"}
            
            # Send to each device individually (or batch if needed)
            results = []
            for device in devices:
                message = {
                    "message": {
                        "token": device.registration_id,
                        "notification": {
                            "title": title,
                            "body": body
                        },
                        "data": data or {}
                    }
                }
                
                response = self._send_fcm_message(message)
                results.append(response)
                
                # Handle failed tokens
                if response.get('error'):
                    device.active = False
                    device.save()
                return {"success": True, "results": results}
        
        except User.DoesNotExist:
            return {"success": False, "message": "User not found"}
        except Exception as e:
            return {"success": False, "message": str(e)}
        


    def _send_fcm_message(self, message):
        """Send message to FCM API"""
        headers = {
            'Authorization': f'Bearer {self.access_token}',
            'Content-Type': 'application/json'
        }
        
        try:
            response = requests.post(
                settings.FIREBASE_POST_REQUEST_URL,
                headers=headers,
                data=json.dumps(message)
            )
            return response.json()
        except Exception as e:
            return {"error": str(e)}