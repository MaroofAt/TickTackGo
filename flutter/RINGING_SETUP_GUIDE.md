# Enabling Zego Call Ringing in TickTackGo

## Current Status

✅ **Working:**
- Group video call UI (participants can join and communicate)
- Workspace owner can initiate calls and select multiple members
- Calls are routed through Zego's prebuilt call widget
- Incoming call alert UI exists (`IncomingCallAlert`)
- Call invitation service decoupled from SDK types

❌ **Missing:**
- Real call invitations sent to recipient devices (currently simulated)
- Device ringing when call starts
- Automatic incoming-call UI display on recipient devices

## Why Ringing Doesn't Work Yet

1. **No real Zego invitation API calls**: The sender in `main.dart` is simulated (just logs)
2. **No incoming-call listener**: Recipients aren't listening for Zego invitation events
3. **No invitation UI overlay**: Even if invitations arrive, there's no UI to show them at app root

## How Zego Call Ringing Works

```
Owner                          Zego Backend                    Recipients
  |                                 |                              |
  +------- sendCallInvitation ----->|                              |
  |                                 +---- onCallInvitation ------->|
  |                                 |    (event triggered)         |
  |                                 |                    +--- show ringing UI
  |                                 |                    +--- play ringtone
  |                                 |                    +--- vibrate device
```

## Implementation Steps

### Step 1: Register Zego Invitation Listener in main.dart

Replace the simulated sender with a real one that uses Zego's API:

```dart
// In main.dart after Firebase initialization:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

IncomingCallNotificationService.registerSender(({
  required String callerID,
  required String callerName,
  required String callID,
  required List<String> recipientIDs,
}) async {
  if (recipientIDs.isEmpty) return;

  try {
    // Build invitee list - use the correct Zego type for your version
    // NOTE: These type names may differ; check your installed SDK
    final invitees = recipientIDs.map((id) => /* ZegoCallUser or similar */).toList();
    
    // Send invitations via Zego
    // await ZegoUIKitPrebuiltCallInvitationService().sendCallInvitation(...);
    // OR use Zego's signaling plugin directly
    
    debugPrint('Zego invitation sent to ${recipientIDs.length} users');
  } catch (e) {
    debugPrint('Error: $e');
  }
});
```

### Step 2: Listen for Incoming Invitations

Add this in `main.dart` or a separate setup function:

```dart
// Hook into Zego's onCallInvitationReceived event
// When triggered, show the IncomingCallAlert
_setupIncomingCallListener() {
  // TODO: Add listener based on installed Zego package
  // Pseudo-code:
  // ZegoUIKitPrebuiltCallInvitationService().onCallInvitationReceived = (
  //   invitation,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => IncomingCallAlert(
  //       callerName: invitation.callerName,
  //       callID: invitation.callID,
  //       onAccept: () {
  //         Navigator.push(...GroupVideoCallPage...);
  //       },
  //       onReject: () {
  //         // Reject invitation
  //       },
  //     ),
  //   );
  // };
}
```

### Step 3: Add Overlay for Incoming Call UI

The `IncomingCallAlert` widget already exists in `lib/presentation/screens/incoming_call_alert.dart`.

To show it globally, wrap it in an `Overlay` at app root or use `showDialog`.

### Step 4: Verify Zego SDK Exports

Check what types/methods are actually exported by your installed Zego package:

```dart
// Run this to see available symbols:
flutter pub get
// Then check in .pubcache or IDE autocompletion
```

Common exported symbols (may vary by version):
- `ZegoUIKitPrebuiltCall` ✓ (used in group_video_call_page.dart)
- `ZegoUIKitPrebuiltCallConfig.groupVideoCall()` ✓
- `ZegoUIKitPrebuiltCallInvitationService` ? (availability unknown)
- `ZegoSignalingPlugin` ? (may require separate import)
- `ZegoUIKitUser` ? (may not be exported)

## Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | Register sender and listener (TODO) |
| `lib/core/services/incoming_call_notification_service.dart` | Decoupled invitation service |
| `lib/core/services/zego_service.dart` | Zego credentials holder |
| `lib/presentation/screens/group_video_call_page.dart` | Group call UI (working) |
| `lib/presentation/screens/incoming_call_alert.dart` | Incoming call ringing UI (needs to be shown) |
| `lib/presentation/screen/workspace/workspace_info_page.dart` | Owner starts call here |

## Debugging

1. **Check logs**: Look for "Sending call invitation" or Zego-related debug prints
2. **Test manually**: 
   - Owner on Device A selects members and taps "Start Call"
   - Check Device B for incoming call UI and sound
3. **Check permissions**: Ensure camera/microphone permissions are granted
4. **Verify credentials**: `ZegoService.appID` and `ZegoService.appSign` must be valid

## Next Steps

1. Find the exact Zego API methods in your installed package (check IDE autocompletion)
2. Update `main.dart` with real invitation calls
3. Add incoming call listener to trigger `IncomingCallAlert`
4. Test on physical devices (simulator sound may not work)
5. Replace debug prints with production logging

## Resources

- See `lib/core/services/zego_ringing_integration.dart` for implementation template
- See `lib/core/services/zego_call_integration_example.dart` for more examples
- Check Zego official docs for your package version

---

**Note**: The current implementation is scaffolded and compiles. Actual ringing requires integrating with Zego's real invitation API which varies by package version. Start by checking what your Zego SDK exports.
