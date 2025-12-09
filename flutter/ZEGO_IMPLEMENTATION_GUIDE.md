# ZegoCloud Video Call Implementation Guide

## Overview
This guide helps you implement ZegoCloud video calling in your Flutter TickTackGo project.

## Step 1: Get ZegoCloud Credentials

1. Go to [ZegoCloud Console](https://console.zego.im/)
2. Sign up or log in
3. Create a new project or use existing one
4. Note down:
   - **App ID** (numeric)
   - **App Sign** (64-character hex string)
5. For production, also get the **Server Secret**

## Step 2: Dependencies Already Added

The required package `zego_uikit_prebuilt_call: ^4.21.1` has been added to your `pubspec.yaml`.

Run `flutter pub get` to install it.

## Step 3: Platform-Specific Configuration

### Android Configuration
Add to `android/app/build.gradle`:
```gradle
android {
    ...
    defaultConfig {
        ...
        minSdkVersion 21
    }
}
```

### iOS Configuration
Add to `ios/Podfile` (uncomment if commented):
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

## Step 4: Update Your Service

Update `lib/core/services/zego_service.dart` with your credentials:

```dart
class ZegoService {
  static const int appID = YOUR_APP_ID; // e.g., 123456789
  static const String appSign = 'YOUR_APP_SIGN'; // 64-char hex string
  
  // Rest of implementation...
}
```

## Step 5: Initialize in main.dart

```dart
import 'package:pr1/core/services/zego_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (existing code)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Initialize ZegoCloud after Firebase
  await ZegoService.initializeZego(
    userID: 'current_user_id', // From authentication
    userName: 'current_user_name', // From authentication
  );
  
  runApp(MyApp(...));
}
```

## Step 6: Create Call Screens

### Video Call Screen
See `lib/presentation/screens/video_call_screen.dart` for the implementation.

### Call Invitation Screen
```dart
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallInvitationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCallInvitationUI();
  }
}
```

## Step 7: Integrate into Your App

### In your main app/home screen, add:
```dart
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your existing UI
      body: Stack(
        children: [
          // Your content
          YourExistingContent(),
          
          // Add this for call invitations
          ZegoUIKitPrebuiltCallInvitationUI(),
        ],
      ),
    );
  }
}
```

## Step 8: Make a Call

### Programmatically Initiate a Call
```dart
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void initiateCall(String targetUserID, String targetUserName) {
  ZegoUIKitPrebuiltCallInvitationService().sendCallInvitation(
    invitees: [ZegoUIKitUser(id: targetUserID, name: targetUserName)],
    isVideoCall: true,
    resourceID: 'zego_call', // For push notifications
  );
}
```

### Add Call Button to UI
```dart
ElevatedButton(
  onPressed: () {
    initiateCall('target_user_id', 'Target User Name');
  },
  child: Text('Start Video Call'),
)
```

## Step 9: Handle Notifications (Optional but Recommended)

Add to your main app:
```dart
Future<void> _setupCallNotifications() async {
  await ZegoUIKitPrebuiltCallInvitationService().setCallInvitationUI(
    onCallDeclined: () {
      print('Call declined');
    },
    onCallEnded: () {
      print('Call ended');
    },
  );
}
```

## Step 10: Cleanup on Logout

```dart
Future<void> logout() async {
  // Your logout logic
  
  // Uninitialize ZegoCloud
  await ZegoService.uninitializeZego();
}
```

## Complete Example

### Modified main.dart
```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:pr1/core/services/zego_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Get current user ID and name from your auth system
  String userID = 'user_123'; // From SharedPreferences or auth service
  String userName = 'John Doe'; // From user profile
  
  await ZegoService.initializeZego(userID: userID, userName: userName);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TickTackGo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TickTackGo')),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _startCall(context),
                  icon: const Icon(Icons.videocam),
                  label: const Text('Start Video Call'),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _sendCallInvitation(),
                  icon: const Icon(Icons.call_made),
                  label: const Text('Send Call Invitation'),
                ),
              ],
            ),
          ),
          // Call invitations UI overlay
          ZegoUIKitPrebuiltCallInvitationUI(),
        ],
      ),
    );
  }

  void _startCall(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoUIKitPrebuiltCall(
          appID: 0, // Replace with your App ID
          appSign: '', // Replace with your App Sign
          userID: 'current_user_id',
          userName: 'Current User',
          callID: 'call_123',
          onOnlySelfInRoom: (context) => Navigator.pop(context),
          onCallEnd: (context) => Navigator.pop(context),
        ),
      ),
    );
  }

  void _sendCallInvitation() {
    ZegoUIKitPrebuiltCallInvitationService().sendCallInvitation(
      invitees: [
        ZegoUIKitUser(id: 'target_user_123', name: 'Target User'),
      ],
      isVideoCall: true,
      resourceID: 'zego_call',
    );
  }
}
```

## Troubleshooting

### Build Errors
- Run `flutter clean` then `flutter pub get`
- Ensure Android minSdkVersion is 21+
- Check iOS deployment target is 10.0+

### No Call Received
- Check credentials (App ID and App Sign)
- Verify internet connection
- Ensure both users are initialized with the same App ID

### Permissions Issues
- Android: Ensure camera and microphone permissions are granted
- iOS: Update `Info.plist` with camera and microphone usage descriptions

## Resources

- [ZegoCloud Documentation](https://docs.zegocloud.com/)
- [Flutter Package Docs](https://pub.dev/packages/zego_uikit_prebuilt_call)
- [GitHub Examples](https://github.com/ZEGOCLOUD/zego_uikit_prebuilt_call_flutter)

## Next Steps

1. Replace App ID and App Sign in your code
2. Test on Android device/emulator
3. Test on iOS device (simulator may have camera issues)
4. Integrate with your existing authentication system
5. Add custom UI styling as needed
6. Implement push notifications for better UX
