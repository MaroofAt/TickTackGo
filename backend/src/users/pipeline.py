import json
import base64

def save_extra_data_from_state(strategy, details, user=None, *args, **kwargs):
    # Extract the raw state parameter from the OAuth2 response
    raw_state = strategy.session_get('state')
    
    if raw_state:
        try:
            # Decode the state (e.g., base64url -> JSON)
            decoded_state = base64.urlsafe_b64decode(raw_state).decode('utf-8')
            extra_data = json.loads(decoded_state)
            
            # Save data to the user model
            user = kwargs['user']
            user.how_to_use_website = extra_data.get('how_to_use_website')
            user.what_do_you_do = extra_data.get('what_do_you_do')
            user.how_did_you_get_here = extra_data.get('how_did_you_get_here')
            user.save()
            
        except (TypeError, json.JSONDecodeError, UnicodeDecodeError) as e:
            print(str(e))
            raise e

    return {'user': user}