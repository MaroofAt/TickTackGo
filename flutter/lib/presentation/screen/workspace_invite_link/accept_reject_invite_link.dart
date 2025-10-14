// lib/screens/invite_screen.dart
import 'package:flutter/material.dart';

class AcceptRejectInviteLink extends StatefulWidget {
  final String senderToken;
  const AcceptRejectInviteLink({super.key, required this.senderToken});

  @override
  State<AcceptRejectInviteLink> createState() => _AcceptRejectInviteLinkState();
}

class _AcceptRejectInviteLinkState extends State<AcceptRejectInviteLink> {
  bool _isLoading = false;

  Future<void> _acceptInvite() async {
    setState(() => _isLoading = true);
    try {
      // Call backend API to join workspace (e.g., POST /api/join-workspace)
      // await ApiService.joinWorkspace(widget.inviteToken);
      // On success: Navigate to workspace dashboard or show success snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Joined workspace!')));
        Navigator.of(context).popUntil((route) => route.isFirst);  // Or go to home
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _rejectInvite() async {
    // Optional: Call backend to invalidate token
    // await ApiService.rejectInvite(widget.inviteToken);
    if (mounted) Navigator.of(context).pop();  // Back to home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Workspace')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Would you like to join this workspace?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _acceptInvite,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Accept'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _rejectInvite,
              child: const Text('Reject'),
            ),
          ],
        ),
      ),
    );
  }
}