import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/constance/task_constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/tasks/create_task_app_bar.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/text_field.dart';

class CreateTaskPage extends StatefulWidget {
  final int workspaceId;
  final int projectId;

  const CreateTaskPage(this.projectId, this.workspaceId, {super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateTaskAppBar.createTaskAppBar(context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: width(context) * 0.35,
                        height: width(context) * 0.35,
                        decoration: BoxDecoration(
                          color: black,
                          shape: BoxShape.circle,
                          image: BlocProvider.of<TaskCubit>(context).image !=
                                  null
                              ? MyImages.decorationFileImage(
                                  image: BlocProvider.of<TaskCubit>(context)
                                      .image!)
                              : MyImages.decorationImage(
                                  isAssetImage: true,
                                  image:
                                      'assets/images/workspace_images/img.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MyGestureDetector.gestureDetector(
                          onTap: () {},
                          child: Container(
                            width: width(context) * 0.08,
                            height: width(context) * 0.08,
                            decoration: const BoxDecoration(
                              color: white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: MyIcons.icon(Icons.add_photo_alternate),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<TaskCubit, TaskState>(
                    builder: (context, state) {
                      return Column(
                        spacing: 20,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.text1(
                                'Title *',
                                textColor: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              const SizedBox(height: 8),
                              MyTextField.textField(
                                context,
                                _titleController,
                                textColor: white,
                                hint: 'task title',
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.text1(
                                'Description',
                                textColor: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              const SizedBox(height: 8),
                              MyTextField.textField(
                                context,
                                _descriptionController,
                                textColor: white,
                                maxLines: 3,
                                hint: 'task description',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              buildStartEndDate(
                                context,
                                label: 'Start Date',
                                onTap: BlocProvider.of<TaskCubit>(context)
                                    .selectStartDate,
                                selectedDate:
                                    BlocProvider.of<TaskCubit>(context)
                                        .selectedStartDate,
                              ),
                              const SizedBox(height: 10),
                              buildStartEndDate(
                                context,
                                label: 'End Date',
                                onTap: BlocProvider.of<TaskCubit>(context)
                                    .selectEndDate,
                                selectedDate:
                                    BlocProvider.of<TaskCubit>(context)
                                        .selectedEndDate,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  MyText.text1('locked: ',
                                      textColor: white, fontSize: 22),
                                  Switch(
                                    value: BlocProvider.of<TaskCubit>(context)
                                        .locked,
                                    onChanged: (value) {
                                      BlocProvider.of<TaskCubit>(context)
                                          .changeTaskLocked();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width(context) * 0.35,
                                child: _buildDropdown(
                                  context,
                                  label: 'parent task',
                                  value: BlocProvider.of<TaskCubit>(context)
                                      .selectedParent,
                                  items: [],
                                  onChanged: (val) => setState(() =>
                                      BlocProvider.of<TaskCubit>(context)
                                          .selectedParent = val),
                                ),
                              ),
                            ],
                          ),
                          buildPriorityWrap(
                            context,
                            'Priority',
                            priorities,
                            BlocProvider.of<TaskCubit>(context)
                                .selectedPriority,
                            BlocProvider.of<TaskCubit>(context)
                                .changeSelectedPriority,
                          ),
                          buildPriorityWrap(
                            context,
                            'status',
                            statuses,
                            BlocProvider.of<TaskCubit>(context).selectedStatus,
                            BlocProvider.of<TaskCubit>(context)
                                .changeSelectedStatus,
                          ),
                        ],
                      );
                    },
                  ),
                  // Row(
                  //   children: [
                  //     buildStartEndTimeSelector(
                  //       context,
                  //       label: 'Start time',
                  //       onTap: _selectStartTime,
                  //       timeFormat: _startTime,
                  //     ),
                  //     const SizedBox(width: 10),
                  //     const Text('~'),
                  //     const SizedBox(width: 10),
                  //     buildStartEndTimeSelector(
                  //       context,
                  //       label: 'End time',
                  //       onTap: _selectEndTime,
                  //       timeFormat: _endTime,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: height(context) * 0.12,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: height(context) * 0.1,
              width: width(context),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                        color: lightGrey.withAlpha(50),
                        spreadRadius: 5,
                        blurRadius: 5)
                  ]),
              child: SizedBox(
                width: width(context) * 0.9,
                height: height(context) * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocConsumer<TaskCubit, TaskState>(
                      listener: (context, state) {
                        if (state is TaskCreatingSucceededState) {
                          popScreen(context, true);
                        }
                        if (state is TaskCreatingFailedState) {
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
                        if (state is TaskCreatingState) {
                          return MyButtons.primaryButton(
                            () {},
                            Theme.of(context).primaryColor,
                            child: Center(
                              child:
                                  LoadingIndicator.circularProgressIndicator(),
                            ),
                          );
                        }
                        return SizedBox(
                          height: height(context) * 0.05,
                          child: MyButtons.primaryButton(
                            () {
                              BlocProvider.of<TaskCubit>(context).createTask(
                                _titleController.text,
                                _descriptionController.text,
                                widget.workspaceId,
                                widget.projectId,
                              );
                            },
                            Theme.of(context).primaryColor,
                            child: Center(
                              child: MyText.text1(
                                'Create Task',
                                textColor: white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                      width: width(context) * 0.3,
                      child: MyButtons.primaryButton(
                        () {
                          popScreen(context);
                        },
                        lightGrey,
                        child: Center(
                          child:
                              MyText.text1('Cancel', textColor: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          focusColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        value: value,
        style: const TextStyle(color: Colors.white),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Column buildStartEndDate(
    BuildContext context, {
    required String label,
    required Function(BuildContext) onTap,
    required DateTime selectedDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.text1(
          label,
          textColor: white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => onTap(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEEE, d MMM y').format(selectedDate),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
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

  Expanded _buildStartEndTimeSelector(
    BuildContext context, {
    required String label,
    required Function(BuildContext) onTap,
    required TimeOfDay timeFormat,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.text1(
              label,
              textColor: white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.text1(
                    timeFormat.format(context),
                    textColor: white,
                    fontSize: 16,
                  ),
                  const Icon(
                    Icons.access_time,
                    size: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
