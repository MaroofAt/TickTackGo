import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/task_constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/tasks/create_task_app_bar.dart';
import 'package:pr1/presentation/screen/tasks/create_task_build_methods.dart';
import 'package:pr1/presentation/widgets/text.dart';

class CreateTaskPage extends StatefulWidget {
  final int workspaceId;
  final int projectId;
  final Map<String, int> tasksTitles;
  final Map<String, int> assignees;

  const CreateTaskPage(
      this.projectId, this.workspaceId, this.tasksTitles, this.assignees,
      {super.key});

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
      body: SizedBox(
        height: height(context),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildSelectImage(context),
                    BlocBuilder<TaskCubit, TaskState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            buildTextFieldsColumn(context, _titleController,
                                _descriptionController),
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
                                buildAssigneesList(context),
                                buildParentTask(context),
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
                            // buildPriorityWrap(
                            //   context,
                            //   'status',
                            //   statuses,
                            //   BlocProvider.of<TaskCubit>(context).selectedStatus,
                            //   BlocProvider.of<TaskCubit>(context)
                            //       .changeSelectedStatus,
                            // ),
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
              child: buildBottomContainer(context, _titleController,
                  _descriptionController, widget.workspaceId, widget.projectId),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildParentTask(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.35,
      child: buildDropdown(
        context,
        label: 'parent task',
        value: BlocProvider.of<TaskCubit>(context).selectedParent,
        items: widget.tasksTitles.keys.toList(),
        onChanged: (val) => setState(
            () => BlocProvider.of<TaskCubit>(context).selectedParent = val),
      ),
    );
  }

  SizedBox buildAssigneesList(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.35,
      child: InkWell(
        onTap: () {
          _showMultiSelectDialog(context);
        },
        child: InputDecorator(
          decoration: const InputDecoration(),
          child: MyText.text1('Select users', textColor: white),
        ),
      ),
    );
  }

  void _showMultiSelectDialog(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return buildSelectUsersAlertDialog(dialogContext, taskCubit);
      },
    );
  }

  AlertDialog buildSelectUsersAlertDialog(
      BuildContext context, TaskCubit taskCubit) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text('Assign to'),
      content: SingleChildScrollView(
        child: BlocBuilder<TaskCubit, TaskState>(
          bloc: taskCubit,
          builder: (context, state) {
            return Column(
              children: widget.assignees.keys.map((item) {
                return CheckboxListTile(
                  value: taskCubit.assignees.contains(widget.assignees[item]),
                  title: SizedBox(
                      width: width(context) * 0.1,
                      height: width(context) * 0.08,
                      child: MyText.text1(item, textColor: white)),
                  onChanged: (bool? checked) {
                    taskCubit.fillAssigneesList(checked, item, widget.assignees);
                    setState(() {});
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => popScreen(context),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
