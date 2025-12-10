/// Copy-Paste Code Snippets for ZegoCloud Integration
/// 
/// Use these snippets directly in your project

// ============================================================================
// SNIPPET 1: Update main.dart
// ============================================================================
// Add this import at the top:
/*
import 'package:pr1/core/services/zego_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
*/

// Replace your main() function with this:
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appRouter = AppRouter();
  final deepLinkService = DeepLinkService(appRouter);
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize ZegoCloud
  try {
    // Get current user from your auth system
    String userID = 'user_123'; // Replace with actual user ID from auth
    String userName = 'User Name'; // Replace with actual user name
    
    await ZegoService.initializeZego(
      userID: userID,
      userName: userName,
    );
  } catch (e) {
    print('Warning: ZegoCloud initialization failed: $e');
    // Continue even if initialization fails
  }

  Future.delayed(Duration.zero, () {
    deepLinkService.initialize();
  });
  
  runApp(MyApp(appRouter: appRouter, deepLinkService: deepLinkService));
}
*/

// ============================================================================
// SNIPPET 2: Add Call Buttons to User Profile
// ============================================================================
/*
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(targetUserName),
      actions: [
        // Add call button to app bar
        IconButton(
          icon: const Icon(Icons.call),
          onPressed: () {
            // Send audio call invitation
            ZegoUIKitPrebuiltCallInvitationService().sendCallInvitation(
              invitees: [
                ZegoUIKitUser(id: targetUserID, name: targetUserName),
              ],
              isVideoCall: false,
              resourceID: 'zego_call',
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {
            // Send video call invitation
            ZegoUIKitPrebuiltCallInvitationService().sendCallInvitation(
              invitees: [
                ZegoUIKitUser(id: targetUserID, name: targetUserName),
              ],
              isVideoCall: true,
              resourceID: 'zego_call',
            );
          },
        ),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // User profile info
          CircleAvatar(
            radius: 50,
            child: Text(targetUserName[0]),
          ),
          const SizedBox(height: 20),
          Text(
            targetUserName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          // Call buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Direct video call (alternative to invitation)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZegoUIKitPrebuiltCall(
                        appID: 0, // CHANGE ME
                        appSign: '', // CHANGE ME
                        userID: currentUserID, // Your user ID
                        userName: currentUserName, // Your user name
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
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Direct audio call
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZegoUIKitPrebuiltCall(
                        appID: 0, // CHANGE ME
                        appSign: '', // CHANGE ME
                        userID: currentUserID,
                        userName: currentUserName,
                        callID: 'call_${DateTime.now().millisecondsSinceEpoch}',
                        onCallEnd: (context) => Navigator.pop(context),
                        onOnlySelfInRoom: (context) => Navigator.pop(context),
                        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.call),
                label: const Text('Voice Call'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
*/

// ============================================================================
// SNIPPET 3: Add Call Invitation UI to Home/Chat Screen
// ============================================================================
/*
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('TickTackGo'),
    ),
    body: Stack(
      children: [
        // Your existing content
        Center(
          child: Text('Chat and Workspace Content'),
        ),
        
        // Add this at the bottom for call invitation UI
        ZegoUIKitPrebuiltCallInvitationUI(),
      ],
    ),
  );
}
*/

// ============================================================================
// SNIPPET 4: Update Auth Logout
// ============================================================================
/*
import 'package:pr1/core/services/zego_service.dart';

Future<void> logout() async {
  try {
    // Uninitialize ZegoCloud
    await ZegoService.uninitializeZego();
    
    // Your existing logout logic
    // await FirebaseAuth.instance.signOut();
    // Navigate to login screen, etc.
    
  } catch (e) {
    print('Error during logout: $e');
  }
}
*/

// ============================================================================
// SNIPPET 5: Create Reusable Call Button Widget
// ============================================================================
/*
class CallButton extends StatelessWidget {
  final String targetUserID;
  final String targetUserName;
  final String currentUserID;
  final String currentUserName;
  final bool isVideoCall;
  final int appID;
  final String appSign;

  const CallButton({
    Key? key,
    required this.targetUserID,
    required this.targetUserName,
    required this.currentUserID,
    required this.currentUserName,
    this.isVideoCall = true,
    required this.appID,
    required this.appSign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ZegoUIKitPrebuiltCall(
              appID: appID,
              appSign: appSign,
              userID: currentUserID,
              userName: currentUserName,
              callID: 'call_${DateTime.now().millisecondsSinceEpoch}',
              onCallEnd: (context) => Navigator.pop(context),
              onOnlySelfInRoom: (context) => Navigator.pop(context),
              config: isVideoCall
                  ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                  : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
            ),
          ),
        );
      },
      icon: Icon(isVideoCall ? Icons.videocam : Icons.call),
      label: Text(isVideoCall ? 'Video Call' : 'Voice Call'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isVideoCall ? Colors.blue : Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// Usage:
CallButton(
  targetUserID: targetUserID,
  targetUserName: targetUserName,
  currentUserID: currentUserID,
  currentUserName: currentUserName,
  isVideoCall: true,
  appID: 0, // CHANGE ME
  appSign: '', // CHANGE ME
)
*/

// ============================================================================
// SNIPPET 6: Reusable Call Invitation Service
// ============================================================================
/*
class CallService {
  static Future<void> sendCallInvitation({
    required String targetUserID,
    required String targetUserName,
    required bool isVideoCall,
    required BuildContext context,
  }) async {
    try {
      await ZegoUIKitPrebuiltCallInvitationService().sendCallInvitation(
        invitees: [
          ZegoUIKitUser(id: targetUserID, name: targetUserName),
        ],
        isVideoCall: isVideoCall,
        resourceID: 'zego_call',
      );
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Call invitation sent to $targetUserName',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  static Future<void> startDirectCall({
    required BuildContext context,
    required String currentUserID,
    required String currentUserName,
    required String targetUserID,
    required String targetUserName,
    required int appID,
    required String appSign,
    required bool isVideoCall,
  }) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZegoUIKitPrebuiltCall(
            appID: appID,
            appSign: appSign,
            userID: currentUserID,
            userName: currentUserName,
            callID: 'call_${DateTime.now().millisecondsSinceEpoch}',
            onCallEnd: (context) => Navigator.pop(context),
            onOnlySelfInRoom: (context) => Navigator.pop(context),
            config: isVideoCall
                ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
          ),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error starting call: $e')),
        );
      }
    }
  }
}

// Usage:
await CallService.sendCallInvitation(
  targetUserID: 'user_123',
  targetUserName: 'John Doe',
  isVideoCall: true,
  context: context,
);
*/

// ============================================================================
// SNIPPET 7: Constants File for ZegoCloud
// ============================================================================
/*
// Create file: lib/core/constants/zego_constants.dart

class ZegoConstants {
  // IMPORTANT: Update these with your ZegoCloud credentials
  static const int APP_ID = 0; // Your App ID - CHANGE THIS
  static const String APP_SIGN = ''; // Your App Sign - CHANGE THIS
  
  // Resource ID for push notifications
  static const String RESOURCE_ID = 'zego_call';
  
  // Call type constants
  static const bool CALL_TYPE_VIDEO = true;
  static const bool CALL_TYPE_AUDIO = false;
}
*/

// ============================================================================
// SNIPPET 8: Error Handling Wrapper
// ============================================================================
/*
class SafeZegoCall {
  static Future<void> initializeWithErrorHandling({
    required String userID,
    required String userName,
  }) async {
    try {
      await ZegoService.initializeZego(
        userID: userID,
        userName: userName,
      );
      print('✅ ZegoCloud initialized successfully');
    } catch (e) {
      print('❌ ZegoCloud initialization error: $e');
      // Don't rethrow - allow app to continue without video calls
    }
  }

  static Future<void> uninitializeWithErrorHandling() async {
    try {
      await ZegoService.uninitializeZego();
      print('✅ ZegoCloud uninitialized');
    } catch (e) {
      print('⚠️ Error during ZegoCloud uninitialize: $e');
      // Don't rethrow - app is already closing
    }
  }
}
*/

// ============================================================================
// USAGE EXAMPLES
// ============================================================================

/*
// EXAMPLE 1: In main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Initialize ZegoCloud
  await SafeZegoCall.initializeWithErrorHandling(
    userID: 'current_user_id',
    userName: 'Current User Name',
  );
  
  runApp(const MyApp());
}

// EXAMPLE 2: On logout
Future<void> logout() async {
  await SafeZegoCall.uninitializeWithErrorHandling();
  // Navigate to login
}

// EXAMPLE 3: Send call invitation from chat
onCallButtonPressed() {
  CallService.sendCallInvitation(
    targetUserID: 'other_user_id',
    targetUserName: 'Other User',
    isVideoCall: true,
    context: context,
  );
}

// EXAMPLE 4: Start direct call from user profile
onVideoCallButtonPressed() {
  CallService.startDirectCall(
    context: context,
    currentUserID: 'my_user_id',
    currentUserName: 'My Name',
    targetUserID: 'target_user_id',
    targetUserName: 'Target Name',
    appID: 123456789,
    appSign: 'abc123xyz789...',
    isVideoCall: true,
  );
}
*/
