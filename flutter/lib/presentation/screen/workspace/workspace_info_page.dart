import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/core/functions/user_functions.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/screen/invitation/invitation_search.dart';
import 'package:pr1/presentation/screen/workspace/build_members_list.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_header.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/divider.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspaceInfoPage extends StatefulWidget {
  int workspaceId;

  WorkspaceInfoPage(this.workspaceId, {super.key});

  @override
  State<WorkspaceInfoPage> createState() => _WorkspaceInfoPageState();
}

class _WorkspaceInfoPageState extends State<WorkspaceInfoPage> {
  RetrieveWorkspaceModel? retrieveWorkspace;

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
    BlocProvider.of<WorkspaceCubit>(context).retrieveWorkspace(widget.workspaceId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WorkspaceCubit, WorkspaceState>(
          builder: (context, state) {
            if (state is WorkspaceRetrievingSucceededState) {
              retrieveWorkspace = state.retrieveWorkspace;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WorkspaceInfoHeader(retrieveWorkspace!),
                    MyDivider.horizontalDivider(
                        thickness: 2, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.text1(
                          membersText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.white,
                        ),
                        MyGestureDetector.gestureDetector(
                          onTap: () {
                            pushScreen(
                              context,
                              BlocProvider(
                                create: (context) => InvitationCubit(),
                                child: InvitationSearch(
                                    senderId: 1,
                                    workspaceId: retrieveWorkspace!.id),
                              ),
                            );
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
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return BlocConsumer<WorkspaceCubit, WorkspaceState>(
      listener: (_, state) {
        if (state is DeletingWorkspaceSucceededState) {
          popScreen(context);
          popScreen(context, true);
        }
        if (state is DeletingWorkspaceFailedState) {
          popScreen(context);
          MyAlertDialog.showAlertDialog(
            context,
            content: state.errorMessage,
            firstButtonText: okText,
            firstButtonAction: () {
              popScreen(context);
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
                  popScreen(context);
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
