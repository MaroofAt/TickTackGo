import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/constance/task_constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/divider.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/text_field.dart';

class InboxBottomSheet extends StatefulWidget {
  final bool withDeleteButton;
  final InboxTasksModel? inboxTasksModel;

  const InboxBottomSheet(this.withDeleteButton,
      {this.inboxTasksModel, super.key});

  @override
  State<InboxBottomSheet> createState() => _InboxBottomSheetState();
}

class _InboxBottomSheetState extends State<InboxBottomSheet> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();


  String getKeyByValue(Map<String, String> map, String value) {
      return map.keys.firstWhere((key) => map[key] == value);
  }

  void initFunction() {
    if (widget.inboxTasksModel != null) {
      BlocProvider.of<InboxCubit>(context).selectedPriority =
          widget.inboxTasksModel!.priority;

      BlocProvider.of<InboxCubit>(context).selectedStatus = getKeyByValue(
          BlocProvider.of<InboxCubit>(context).statuses,
          widget.inboxTasksModel!.status);
    }
  }

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTextFieldWithLabel(
                    context, 'Title *', 'Enter title', _titleController),
                const SizedBox(height: 20),
                buildTextFieldWithLabel(context, 'description *',
                    'Enter description', _descriptionController, 3),
                const SizedBox(height: 20),
                buildHorizontalDivider(context),
                BlocBuilder<InboxCubit, InboxState>(
                  builder: (context, state) {
                    return buildPriorityWrap(
                      context,
                      'Priority',
                      priorities,
                      BlocProvider.of<InboxCubit>(context).selectedPriority,
                      BlocProvider.of<InboxCubit>(context)
                          .changePriorityInCreateTask,
                    );
                  },
                ),
                const SizedBox(height: 20),
                buildHorizontalDivider(context),
                const SizedBox(height: 20),
                BlocBuilder<InboxCubit, InboxState>(
                  builder: (context, state) {
                    return buildPriorityWrap(
                      context,
                      'Status',
                      statuses,
                      BlocProvider.of<InboxCubit>(context).selectedStatus,
                      BlocProvider.of<InboxCubit>(context)
                          .changeStatusInCreateTask,
                    );
                  },
                ),
                SizedBox(height: height(context) * 0.15),
                SizedBox(
                  width: width(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildBottomButtons(
                        context,
                        BlocConsumer<InboxCubit, InboxState>(
                          listener: (context, state) {
                            if (state is InboxCreatingSucceededState) {
                              NavigationService().popScreen(context, true);
                            } else if (state
                                is InboxTaskUpdatingSucceededState) {
                              NavigationService().popScreen(context, 'updating successfully');
                            } else if (state is InboxCreatingFailedState) {
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
                            } else if (state is InboxTaskUpdatingFailedState) {
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
                            } else if (state
                                is InboxTaskDestroyingSucceededState) {
                              NavigationService().popScreen(context, 'destroying successfully');
                            } else if (state
                                is InboxTaskDestroyingFailedState) {
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
                            if (state is InboxCreatingState ||
                                state is InboxTaskUpdatingState) {
                              return LoadingIndicator.circularProgressIndicator(
                                color: white,
                              );
                            }
                            return buildButtonText(
                                widget.withDeleteButton ? 'Change' : 'Add');
                          },
                        ),
                        Theme.of(context).primaryColor,
                        () {
                          if (widget.withDeleteButton) {
                            BlocProvider.of<InboxCubit>(context)
                                .updateInboxTask(
                              widget.inboxTasksModel!.id,
                              widget.inboxTasksModel!,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              priority: BlocProvider.of<InboxCubit>(context)
                                  .selectedPriority,
                              status:
                                  BlocProvider.of<InboxCubit>(context).statuses[
                                      BlocProvider.of<InboxCubit>(context)
                                          .selectedStatus]!,
                            );
                            NavigationService().popScreen(context);
                          } else {
                            BlocProvider.of<InboxCubit>(context)
                                .createInboxTask(
                              _titleController.text,
                              _descriptionController.text,
                            );
                          }
                        },
                      ),
                      buildBottomButtons(
                        context,
                        buildButtonText(
                            widget.withDeleteButton ? 'Delete' : 'Cancel'),
                        ampleOrange,
                        () {
                          if (widget.withDeleteButton) {
                            BlocProvider.of<InboxCubit>(context)
                                .destroyInboxTask(widget.inboxTasksModel!.id);
                            NavigationService().popScreen(context);
                          } else {
                            NavigationService().popScreen(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildButtonText(String text) {
    return MyText.text1(
      text,
      textColor: white,
      fontSize: 18,
      letterSpacing: 2,
    );
  }

  SizedBox buildBottomButtons(BuildContext context, Widget child,
      Color backGroundColor, void Function() onPressed) {
    return SizedBox(
      width: width(context) * 0.4,
      child: MyButtons.primaryButton(
        onPressed,
        backGroundColor,
        child: Center(
          child: child,
        ),
      ),
    );
  }

  Widget buildHorizontalDivider(BuildContext context) {
    return MyDivider.horizontalDivider(
        color: Theme.of(context).primaryColor, thickness: 2);
  }

  Column buildPriorityWrap(BuildContext context, String label,
      List<String> list, String selectedValue, Function(String text) onTap) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: width(context),
          child: MyText.text1('$label :',
              textColor: white, fontSize: 18, textAlign: TextAlign.start),
        ),
        Wrap(
          spacing: 10,
          children: list.map(
            (item) {
              return MyGestureDetector.gestureDetector(
                onTap: () {
                  onTap(item);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: item,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        onTap(value!);
                      },
                      activeColor: white,
                    ),
                    MyText.text1(
                      item,
                      textColor: white,
                      fontSize: 14,
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget buildTextFieldWithLabel(BuildContext context, String label,
      String hint, TextEditingController controller,
      [int maxLines = 1]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.text1(label, textColor: lightGrey, fontSize: 18),
        const SizedBox(height: 8.0),
        MyTextField.textField(
          context,
          controller,
          hint: hint,
          maxLines: maxLines,
          textColor: white,
        ),
      ],
    );
  }
}
