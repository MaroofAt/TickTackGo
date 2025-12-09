import 'package:flutter/material.dart';

/// Widget to display incoming call alert with accept/reject options
class IncomingCallAlert extends StatefulWidget {
  final String callerID;
  final String callerName;
  final String callID;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const IncomingCallAlert({
    super.key,
    required this.callerID,
    required this.callerName,
    required this.callID,
    required this.onAccept,
    required this.onReject,
  });

  @override
  State<IncomingCallAlert> createState() => _IncomingCallAlertState();
}

class _IncomingCallAlertState extends State<IncomingCallAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Start ringing animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ringing animation
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.1).animate(
                CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOut),
              ),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.videocam,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Incoming Video Call',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.callerName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reject button
                GestureDetector(
                  onTap: widget.onReject,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                ),
                // Accept button
                GestureDetector(
                  onTap: widget.onAccept,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.videocam,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to show incoming call dialog
Future<bool?> showIncomingCallDialog(
  BuildContext context, {
  required String callerID,
  required String callerName,
  required String callID,
  required Function() onAccept,
  required Function() onReject,
}) {
  return showDialog<bool?>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return IncomingCallAlert(
        callerID: callerID,
        callerName: callerName,
        callID: callID,
        onAccept: () {
          Navigator.pop(context, true);
          onAccept();
        },
        onReject: () {
          Navigator.pop(context, false);
          onReject();
        },
      );
    },
  );
}
