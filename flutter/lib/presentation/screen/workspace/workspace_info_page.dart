import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invite_link_cubit/invite_link_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/core/functions/show_snack_bar.dart';
import 'package:pr1/core/functions/user_functions.dart';
import 'package:pr1/core/services/incoming_call_notification_service.dart';
import 'package:pr1/core/variables/global_var.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/screen/workspace/build_members_list.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_header.dart';
import 'package:pr1/presentation/screen/workspace_invite_link/create_invitation_link_dialog.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/divider.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspaceInfoPage extends StatefulWidget {
  final int workspaceId;
  final WorkspaceCubit workspaceCubit;

  const WorkspaceInfoPage(
      {required this.workspaceId, required this.workspaceCubit, super.key});

  @override
  State<WorkspaceInfoPage> createState() => _WorkspaceInfoPageState();
}

class _WorkspaceInfoPageState extends State<WorkspaceInfoPage> {
  RetrieveWorkspaceModel? retrieveWorkspace;
  final Set<int> selectedMemberIDs =
      {}; // Track selected members for multi-call

  @override
  void initState() {
    super.initState();
    getWorkspace();
  }

  getWorkspace() {
    if (retrieveWorkspace != null &&
        widget.workspaceId == retrieveWorkspace!.id) {
      return;
    }
    BlocProvider.of<WorkspaceCubit>(context)
        .retrieveWorkspace(widget.workspaceId);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && result != null) {
          widget.workspaceCubit.fetchWorkspaces();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<WorkspaceCubit, WorkspaceState>(
            builder: (context, state) {
              if (state is WorkspaceRetrievingSucceededState) {
                retrieveWorkspace = state.retrieveWorkspace;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WorkspaceInfoHeader(retrieveWorkspace!),
                      const SizedBox(height: 20),
                      MyDivider.horizontalDivider(
                          thickness: 2, color: Colors.grey),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width(context),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildShowInvitesText(context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyGestureDetector.gestureDetector(
                                  onTap: () {
                                    if (isAdmin(retrieveWorkspace!.owner!.id)) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (context) =>
                                                InviteLinkCubit(),
                                            child: CreateInvitationLinkDialog(
                                              workspaceId:
                                                  retrieveWorkspace!.id,
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      showSnackBar(
                                        context,
                                        'You are not the owner of this workspace',
                                        backgroundColor: Colors.red,
                                        seconds: 1,
                                        milliseconds: 500,
                                      );
                                    }
                                  },
                                  child: Container(
                                    color: transparent,
                                    child: MyText.text1(
                                      'create invitation link?',
                                      textColor: Colors.blue,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText.text1(
                                membersText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                              ),
                              MyGestureDetector.gestureDetector(
                                onTap: () {
                                  if (retrieveWorkspace == null) {
                                    showSnackBar(
                                      context,
                                      'Workspace not found',
                                      backgroundColor: Colors.red,
                                      seconds: 1,
                                      milliseconds: 500,
                                    );
                                    return;
                                  }
                                  if (isAdmin(retrieveWorkspace!.owner!.id)) {
                                    if (retrieveWorkspace!.members.isEmpty) {
                                      showSnackBar(
                                        context,
                                        'No members in this workspace to call',
                                        backgroundColor: Colors.orange,
                                        seconds: 1,
                                        milliseconds: 500,
                                      );
                                      return;
                                    }
                                    _showMembersDialog(context);
                                  } else {
                                    showSnackBar(
                                      context,
                                      'You are not the owner of this workspace',
                                      backgroundColor: Colors.red,
                                      seconds: 1,
                                      milliseconds: 500,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.video_call,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          MyGestureDetector.gestureDetector(
                            onTap: () {
                              if (isAdmin(retrieveWorkspace!.owner!.id)) {
                                NavigationService().push(
                                  context,
                                  '$invitationSearchRoute/${retrieveWorkspace!.owner!.id}/${retrieveWorkspace!.id}',
                                );
                              } else {
                                showSnackBar(
                                  context,
                                  'You are not the owner of this workspace',
                                  backgroundColor: Colors.red,
                                  seconds: 1,
                                  milliseconds: 500,
                                );
                              }
                            },
                            child: Container(
                              height: width(context) * 0.1,
                              width: width(context) * 0.3,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: MyText.text1(
                                  'Invite',
                                  textColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: BuildMembersList(
                          retrieveWorkspace!,
                        ),
                      ),
                      // Delete Button
                      isAdmin(retrieveWorkspace!.owner!.id)
                          ? BlocProvider(
                              create: (context) => WorkspaceCubit(),
                              child: buildDeleteButton(context),
                            )
                          : Container(),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: LoadingIndicator.circularProgressIndicator(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _showMembersDialog(BuildContext context) {
    selectedMemberIDs.clear(); // Reset selection
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select members to call'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: retrieveWorkspace!.members.length,
                        itemBuilder: (context, index) {
                          final member = retrieveWorkspace!.members[index];
                          final isSelected =
                              selectedMemberIDs.contains(member.member.id);
                          return CheckboxListTile(
                            title: MyText.text1(
                              member.member.username,
                              textColor: white,
                            ),
                            subtitle: Text(member.member.email),
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value ?? false) {
                                  selectedMemberIDs.add(member.member.id);
                                } else {
                                  selectedMemberIDs.remove(member.member.id);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Selected: ${selectedMemberIDs.length} member(s)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: selectedMemberIDs.isEmpty
                      ? null
                      : () {
                          Navigator.pop(dialogContext);
                          _startGroupVideoCall(context);
                        },
                  child: const Text('Start Call'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _startGroupVideoCall(BuildContext context) async {
    if (user == null) {
      showSnackBar(
        context,
        'User not authenticated',
        backgroundColor: Colors.red,
        seconds: 1,
        milliseconds: 500,
      );
      return;
    }

    final String callID = '${DateTime.now().millisecondsSinceEpoch}';
    final List<String> targetUserIDs =
        selectedMemberIDs.map((id) => id.toString()).toList();

    try {
      // Send incoming call notifications to selected members
      await IncomingCallNotificationService.sendIncomingCallNotification(
        callerID: user!.id.toString(),
        callerName: user!.username,
        callID: callID,
        recipientIDs: targetUserIDs,
      );

      showSnackBar(
        context,
        'Calling ${selectedMemberIDs.length} member(s)...',
        backgroundColor: Colors.green,
        seconds: 1,
        milliseconds: 800,
      );

      // Navigate to group call page
      if (mounted) {
        NavigationService()
            .push(context, groupCallPageRoute, args: <String, dynamic>{
          'currentUserID': user!.id.toString(),
          'currentUserName': user!.username,
          'targetUserIDs': targetUserIDs,
          'callID': callID,
          'workspaceName': retrieveWorkspace?.title,
        });
      }
    } catch (e) {
      showSnackBar(
        context,
        'Error starting group call: $e',
        backgroundColor: Colors.red,
        seconds: 2,
        milliseconds: 0,
      );
    }
  }

  Widget buildShowInvitesText(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: () {
        if (isAdmin(retrieveWorkspace!.owner!.id)) {
          NavigationService()
              .push(context, '$sentInvitesPageRoute/${retrieveWorkspace!.id}');
        } else {
          showSnackBar(
            context,
            'You are not the owner of this workspace',
            backgroundColor: Colors.red,
            seconds: 1,
            milliseconds: 500,
          );
        }
      },
      child: Container(
        color: transparent,
        child: MyText.text1(
          'show sent invites?',
          textColor: Colors.blue,
          fontSize: 20,
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return BlocConsumer<WorkspaceCubit, WorkspaceState>(
      listener: (_, state) {
        if (state is DeletingWorkspaceSucceededState) {
          NavigationService().popScreen(context);
          NavigationService().popScreen(context, true);
        }
        if (state is DeletingWorkspaceFailedState) {
          NavigationService().popScreen(context);
          MyAlertDialog.showAlertDialog(
            context,
            content: state.errorMessage,
            firstButtonText: okText,
            firstButtonAction: () {
              NavigationService().popScreen(context);
            },
            secondButtonText: '',
            secondButtonAction: () {},
          );
        }
      },
      builder: (context, state) {
        if (state is DeletingWorkspaceState) {
          return Center(
            child: LoadingIndicator.circularProgressIndicator(),
          );
        }
        return Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              MyAlertDialog.showAlertDialog(
                context,
                content: alertDialogQuestion,
                firstButtonText: deleteText,
                firstButtonAction: () {
                  BlocProvider.of<WorkspaceCubit>(context)
                      .deleteWorkspace(retrieveWorkspace!.id);
                },
                secondButtonText: cancelText,
                secondButtonAction: () {
                  NavigationService().popScreen(context);
                },
              );
            },
            child: MyText.text1(deleteButtonText, fontSize: 18),
          ),
        );
      },
    );
  }
}
