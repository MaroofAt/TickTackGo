import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/circle.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/text_field.dart';

class CreateWorkspacePage extends StatelessWidget {
  CreateWorkspacePage({super.key});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height(context) * 0.9,
          width: width(context),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: height(context) * 0.08),
                    MyText.text1(pageTitle, fontSize: 25, textColor: white),
                    SizedBox(height: height(context) * 0.02),
                    Column(
                      children: [
                        BlocConsumer<WorkspaceCubit, WorkspaceState>(
                          listener: (context, state) {
                            if (state is CreatedWorkspaceState) {
                              popScreen(context);
                            }
                            if (state is CreateWorkspaceFailedState) {
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
                            return Stack(
                              children: [
                                BlocProvider.of<WorkspaceCubit>(context)
                                            .image ==
                                        null
                                    ? MyCircle.circle(
                                        width(context) * 0.35,
                                        color: white,
                                      )
                                    : MyCircle.circleWithFileImage(
                                        width(context) * 0.35,
                                        file: BlocProvider.of<WorkspaceCubit>(
                                                context)
                                            .image!),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: BlocListener<WorkspaceCubit,
                                      WorkspaceState>(
                                    listener: (context, state) {
                                      if (state
                                          is PermissionPermanentlyDeniedState) {
                                        MyAlertDialog.showAlertDialog(
                                          context,
                                          content:
                                              permissionPermanentlyDeniedContent,
                                          firstButtonText: openSettingsString,
                                          firstButtonAction: () {
                                            openAppSettings();
                                            popScreen(context);
                                          },
                                          secondButtonText: cancelText,
                                          secondButtonAction: () {
                                            popScreen(context);
                                          },
                                          reverseColors: true,
                                        );
                                      }
                                      if (state is SomethingWentWrongState) {
                                        MyAlertDialog.showAlertDialog(
                                          context,
                                          content:
                                              'something went wrong please try again later',
                                          firstButtonText: okText,
                                          firstButtonAction: () {
                                            popScreen(context);
                                          },
                                          secondButtonText: '',
                                          secondButtonAction: () {},
                                        );
                                      }
                                    },
                                    child: MyGestureDetector.gestureDetector(
                                      onTap: () {
                                        BlocProvider.of<WorkspaceCubit>(context)
                                            .getWorkspaceImage();
                                      },
                                      child: MyCircle.circle(
                                        width(context) * 0.1,
                                        color: Theme.of(context).primaryColor,
                                        child: MyIcons.icon(
                                          Icons.add_photo_alternate_outlined,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: width(context) * 0.9,
                          height: height(context) * 0.23,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.text1('Title *',
                                  textColor: white, fontSize: 20),
                              MyTextField.textField(
                                context,
                                _titleController,
                                hint: titleHint,
                                textColor: white,
                                borderColor: greatMagenda,
                              ),
                              const SizedBox(height: 20),
                              MyText.text1('Description *',
                                  textColor: white, fontSize: 20),
                              MyTextField.textField(
                                context,
                                _descriptionController,
                                hint: descriptionHint,
                                type: TextInputType.multiline,
                                textColor: white,
                                minLines: 1,
                                maxLines: 3,
                                borderColor: greatMagenda,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height(context) * 0.26),
                SizedBox(
                  width: width(context) * 0.45,
                  height: height(context) * 0.06,
                  child: MyButtons.primaryButton(
                    () {
                      BlocProvider.of<WorkspaceCubit>(context).createWorkSpace(
                        _titleController.text,
                        _descriptionController.text,
                      );
                    },
                    Theme.of(context).secondaryHeaderColor,
                    child: MyText.text1(
                      createButtonText,
                      fontSize: 20,
                      textColor: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
