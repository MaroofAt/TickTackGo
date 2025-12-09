import 'package:flutter/material.dart';
import 'package:pr1/core/services/zego_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

/// Group video call page supporting multiple participants
class GroupVideoCallPage extends StatefulWidget {
  final String currentUserID;
  final String currentUserName;
  final List<String> targetUserIDs; // Multiple participant IDs
  final String callID;
  final String? workspaceName;

  const GroupVideoCallPage({
    super.key,
    required this.currentUserID,
    required this.currentUserName,
    required this.targetUserIDs,
    required this.callID,
    this.workspaceName,
  });

  @override
  State<GroupVideoCallPage> createState() => _GroupVideoCallPageState();
}

class _GroupVideoCallPageState extends State<GroupVideoCallPage> {
  late String callID;

  @override
  void initState() {
    super.initState();
    callID = widget.callID;
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: ZegoService.appID,
      appSign: ZegoService.appSign,
      userID: widget.currentUserID,
      userName: widget.currentUserName,
      callID: callID,
      // Use group video call configuration for multi-user support
      config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
    );
  }
}
