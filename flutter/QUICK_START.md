# ZegoCloud Video Call Implementation - Quick Start

## What Has Been Done

✅ **Dependencies Added:**
- `zego_uikit_prebuilt_call: ^4.21.1` added to `pubspec.yaml`
- Run `flutter pub get` to download the packages

✅ **Files Created:**
1. `lib/core/services/zego_service.dart` - Service class for ZegoCloud initialization
2. `lib/presentation/screens/video_call_page.dart` - Video call UI screen
3. `lib/core/services/zego_call_integration_example.dart` - Integration examples
4. `ZEGO_IMPLEMENTATION_GUIDE.md` - Detailed implementation guide

## Quick Start Steps

### 1. Get ZegoCloud Credentials (5 minutes)
1. Visit [ZegoCloud Console](https://console.zego.im/)
2. Sign up/login
3. Create a project
4. Copy your **App ID** (numeric) and **App Sign** (64-character hex string)

### 2. Update Credentials in Code
Update these files with your credentials:

**File: `lib/core/services/zego_service.dart`**
```dart
class ZegoService {
  static const int appID = 12345678; // Replace with your App ID
  static const String appSign = 'abc123def456...'; // Replace with your App Sign
}
```

**File: `lib/presentation/screens/video_call_page.dart`**
```dart
return ZegoUIKitPrebuiltCall(
  appID: 12345678, // Replace
  appSign: 'abc123def456...', // Replace
  ...
)
```

### 3. Initialize in main.dart

Add after Firebase initialization:

```dart
import 'package:pr1/core/services/zego_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Initialize ZegoCloud after Firebase
  String currentUserID = 'YOUR_USER_ID'; // Get from your auth system
  String currentUserName = 'YOUR_USER_NAME'; // Get from user profile
  
  await ZegoService.initializeZego(
    userID: currentUserID,
    userName: currentUserName,
  );
  
  runApp(MyApp(...));
}
```

### 4. Add Call UI to Your App

In your main home/chat screen:

```dart
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Your existing UI
        YourExistingContent(),
        
        // Add call invitation overlay at the top
        ZegoUIKitPrebuiltCallInvitationUI(),
      ],
    ),
  );
}
```

### 5. Add Call Buttons to User Profile/Chat

```dart
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// In your user profile or chat screen:
ElevatedButton.icon(
  onPressed: () {
    // Start video call
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoUIKitPrebuiltCall(
          appID: 12345678,
          appSign: 'your_app_sign',
          userID: currentUserID,
          userName: currentUserName,
          callID: 'call_${DateTime.now().millisecondsSinceEpoch}',
          onCallEnd: (context) => Navigator.pop(context),
          onOnlySelfInRoom: (context) => Navigator.pop(context),
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
        ),
      ),
    );
  },
  icon: const Icon(Icons.videocam),
  label: const Text('Video Call'),
)
```

### 6. Send Call Invitations (Alternative to Direct Call)

```dart
// Send invitation instead of direct call
ZegoUIKitPrebuiltCallInvitationService().sendCallInvitation(
  invitees: [
    ZegoUIKitUser(id: targetUserID, name: targetUserName),
  ],
  isVideoCall: true,
  resourceID: 'zego_call', // For push notifications
);
```

## Platform-Specific Setup

### Android
Update `android/app/build.gradle`:
```gradle
android {
    ...
    defaultConfig {
        ...
        minSdkVersion 21 // Must be 21 or higher
    }
}
```

### iOS
Update `ios/Podfile` - ensure this is uncommented:
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

## Testing

### Start Simple
1. Run on Android emulator or device first
2. Test voice call first before video
3. Then test on iOS

### Test Checklist
- [ ] Two users can initiate a call
- [ ] Video/audio works on both ends
- [ ] Call can be ended
- [ ] Call invitation UI appears
- [ ] Notifications work (optional)

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| "Method not found" errors | Run `flutter pub get` then `flutter clean` |
| Black screen during call | Check camera permissions |
| No audio | Check microphone permissions |
| Call won't connect | Verify App ID and App Sign are correct |
| Build fails | Ensure Android minSdk ≥ 21, iOS deployment target ≥ 10 |

## File Reference

| File | Purpose |
|------|---------|
| `lib/core/services/zego_service.dart` | Initialization & configuration |
| `lib/presentation/screens/video_call_page.dart` | Main video call UI |
| `lib/core/services/zego_call_integration_example.dart` | Code examples |
| `ZEGO_IMPLEMENTATION_GUIDE.md` | Detailed reference guide |

## Next Steps

1. **Get credentials** from ZegoCloud console
2. **Update code** with your credentials
3. **Test on device** (especially Android first)
4. **Integrate with authentication** - get user ID from your auth system
5. **Customize UI** - modify colors, buttons, etc. as needed
6. **Add notifications** - set up push notifications for better UX
7. **Deploy** - test thoroughly before going live

## Support & Resources

- [ZegoCloud Docs](https://docs.zegocloud.com/article/14807)
- [Flutter Package](https://pub.dev/packages/zego_uikit_prebuilt_call)
- [GitHub Examples](https://github.com/ZEGOCLOUD/zego_uikit_prebuilt_call_flutter)

## Important Notes

⚠️ **Before Production:**
- Replace hardcoded credentials with secure configuration
- Implement server-side token generation for production
- Set up proper error handling and logging
- Test on real devices (simulators have camera limitations)
- Implement user presence/status checking
- Add timeout handling for missed calls

## Questions?

Refer to:
1. `ZEGO_IMPLEMENTATION_GUIDE.md` for detailed steps
2. `lib/core/services/zego_call_integration_example.dart` for code samples
3. Official ZegoCloud documentation
