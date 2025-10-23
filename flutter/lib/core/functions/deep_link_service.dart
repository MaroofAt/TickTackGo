import 'dart:async';

import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/core/constance/strings.dart';

class DeepLinkService {
  final AppRouter _appRouter;
  final Completer<void> _initializationCompleter = Completer();

  DeepLinkService(this._appRouter);

  void initialize() {
    print('DeepLinkService initialized');
    _initializationCompleter.complete();
  }

  Future<void> handleDeepLink(Uri uri) async {
    print('Handling deep link: $uri');

    // Wait for initialization to complete
    await _initializationCompleter.future;

    print('DeepLinkService is ready, processing deep link');

    if (uri.pathSegments.length >= 3 &&
        uri.pathSegments[0] == 'invite-link' &&
        uri.pathSegments[2] == 'join-us') {

      final inviteToken = uri.pathSegments[1];
      print('Extracted invite token: $inviteToken');

      await _navigateToInviteLink(inviteToken);
    } else {
      print('Invalid deep link format');
    }
  }

  Future<void> _navigateToInviteLink(String inviteToken) async {
    try {
      final routePath = '$acceptRejectInviteLinkRoute/$inviteToken/join-us';
      print('Navigating to: $routePath');

      // Ensure we're in a stable state before navigating
      await Future.delayed(const Duration(milliseconds: 200));

      _appRouter.router.push(routePath, extra: inviteToken);
      print('Navigation completed successfully');
    } catch (e, stackTrace) {
      print('Error navigating to invite link: $e');
      print('Stack trace: $stackTrace');

      // Retry once after a longer delay
      await Future.delayed(const Duration(seconds: 1));
      try {
        _appRouter.router.push('$acceptRejectInviteLinkRoute/$inviteToken/join-us', extra: inviteToken);
      } catch (e2) {
        print('Failed again after retry: $e2');
      }
    }
  }
}