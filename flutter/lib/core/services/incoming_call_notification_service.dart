import 'package:flutter/foundation.dart';

/// Service to handle incoming call notifications and ringing
/// Uses Zego's built-in call invitation and signaling system
class IncomingCallNotificationService {
  static final IncomingCallNotificationService _instance =
      IncomingCallNotificationService._internal();

  factory IncomingCallNotificationService() {
    return _instance;
  }

  IncomingCallNotificationService._internal();

  /// Send incoming call notification to multiple users
  /// This leverages Zego's prebuilt invitation system which automatically:
  /// 1. Shows incoming call UI on recipient devices
  /// 2. Rings the device with system sound
  /// 3. Keeps the call invitation active until accepted/rejected
  static Future<void> sendIncomingCallNotification({
    required String callerID,
    required String callerName,
    required String callID,
    required List<String> recipientIDs,
  }) async {
    if (recipientIDs.isEmpty) {
      debugPrint('No recipients provided for call invitation');
      return;
    }

    // If an app-level sender has been registered (for example, in main.dart
    // where Zego types are available), delegate to it. This avoids directly
    // depending on SDK types here and keeps the service testable.
    if (_sender != null) {
      await _sender!(
        callerID: callerID,
        callerName: callerName,
        callID: callID,
        recipientIDs: recipientIDs,
      );
      return;
    }

    // Fallback: log the invitation attempt. Integrate your actual Zego
    // invitation calls by registering a sender via
    // `IncomingCallNotificationService.registerSender(...)`.
    debugPrint(
        'Simulated sending call invitation from $callerName to ${recipientIDs.length} users (callID=$callID)');
  }

  /// Type for a custom call-invitation sender implementation
  /// Replace or register an implementation that uses Zego SDK APIs.
  static Future<void> Function({
    required String callerID,
    required String callerName,
    required String callID,
    required List<String> recipientIDs,
  })? _sender;

  /// Register an app-level sender implementation (e.g., that uses Zego SDK)
  static void registerSender(
      Future<void> Function({
        required String callerID,
        required String callerName,
        required String callID,
        required List<String> recipientIDs,
      }) sender) {
    _sender = sender;
    debugPrint('IncomingCallNotificationService sender registered');
  }

  /// Notify that a user joined the call
  static void notifyUserJoined(String userID, String userName) {
    print('User $userName ($userID) joined the call');
  }

  /// Notify that a user left the call
  static void notifyUserLeft(String userID, String userName) {
    print('User $userName ($userID) left the call');
  }

  /// Get call duration string
  static String getFormattedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
