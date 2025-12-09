// Intentionally do not import Zego types here to keep this file a lightweight holder
// of credentials. Widgets will import the prebuilt package where needed.

/// Minimal Zego service holder. The prebuilt widgets accept `appID`/`appSign`
/// directly. Keep credentials here and call `initializeZego` from your auth
/// flow if you need lifecycle hooks.
class ZegoService {
  /// Replace these with your ZegoCloud credentials
  static const int appID = 225551279; // <-- set your numeric App ID
  static const String appSign = '0124fb5a8b698db51b42c8dd3e7b41b193028ec2aa41117d40169c99d22df11b'; // <-- set your App Sign

  /// Called after user login to perform any necessary initialization.
  /// For most prebuilt uses the widget accepts credentials directly,
  /// so this is a convenient place to run app-level setup if needed.
  static Future<void> initializeZego({
    required String userID,
    required String userName,
  }) async {
    // Currently no-op. Keep for lifecycle hooks and server-token fetch.
    // Example: fetch user token from backend here for production.
    // await fetchZegoToken(userID);
    // You can also configure invitation UI here if you need.
    print('ZegoService.initializeZego called for $userName ($userID)');
  }

  /// Cleanup (called on logout)
  static Future<void> uninitializeZego() async {
    // Placeholder for any cleanup if required by future SDK calls
    print('ZegoService.uninitializeZego called');
  }

  /// Helper to expose credentials
  static Map<String, dynamic> get credentials => {
        'appID': appID,
        'appSign': appSign,
      };
}
