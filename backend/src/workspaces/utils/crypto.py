from cryptography.fernet import Fernet
from django.conf import settings
import json

# print(Fernet.generate_key().decode())

class Crypto:
    def __init__(self):
        self.key = settings.FERNET_KEY.encode()  # Ensure this is set in settings.py
        self.cipher = Fernet(self.key)

    def encrypt(self, data):
        """Encrypts a dictionary or string."""
        if isinstance(data, dict):
            data = json.dumps(data)  # Convert dict → JSON string
        if isinstance(data, str):
            data = data.encode()     # Convert string → bytes
        encrypted = self.cipher.encrypt(data)
        return encrypted.decode()    # Return as string (for JSON responses)

    def decrypt(self, encrypted_data):
        """Decrypts data back to a dictionary or string."""
        if isinstance(encrypted_data, str):
            encrypted_data = encrypted_data.encode()  # Convert string → bytes
        decrypted = self.cipher.decrypt(encrypted_data).decode()
        try:
            return json.loads(decrypted)  # Try to parse as JSON (dict)
        except json.JSONDecodeError:
            return decrypted              # Return as plain string if not JSON