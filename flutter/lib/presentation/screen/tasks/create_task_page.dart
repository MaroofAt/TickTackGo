import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/task_constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/tasks/create_task_app_bar.dart';
import 'package:pr1/presentation/screen/tasks/create_task_build_methods.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  int? workspaceId;
  int? projectId;
  Map<String, int>? tasksTitles;
  Map<String, int>? assignees;
  TaskCubit? taskCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    workspaceId = args['workspaceId'];
    projectId = args['projectId'];
    tasksTitles = args['tasksTitles'];
    assignees = args['assignees'];
    taskCubit = args['taskCubit'];
  }

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && result != null) {
          taskCubit!.fetchTasks(projectId!);
        }
      },
      child: Scaffold(
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
                                  const SizedBox(height: 10),
                                  buildStartEndDate(
                                    context,
                                    label: 'reminder',
                                    onTap: BlocProvider.of<TaskCubit>(context)
                                        .selectReminderDate,
                                    selectedDate:
                                        BlocProvider.of<TaskCubit>(context)
                                            .selectedReminderDate,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              const SizedBox(height: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyButtons.primaryButton(
                                    () {
                                      BlocProvider.of<TaskCubit>(context)
                                          .uploadAttachments();
                                    },
                                    Theme.of(context).secondaryHeaderColor,
                                    child: MyText.text1('Upload file'),
                                  ),
                                  BlocProvider.of<TaskCubit>(context).result ==
                                          null
                                      ? Container()
                                      : buildUploadedFiles(context),
                                ],
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
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: buildBottomContainer(
                    context,
                    _titleController,
                    _descriptionController,
                    tasksTitles!,
                    workspaceId!,
                    projectId!),
              ),
            ],
          ),
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
        items: tasksTitles!.keys.toList(),
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
          child: MyText.text1('Select users *', textColor: white),
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
              children: assignees!.keys.map((item) {
                return CheckboxListTile(
                  value: taskCubit.assignees.contains(assignees![item]),
                  title: SizedBox(
                      width: width(context) * 0.1,
                      height: width(context) * 0.08,
                      child: MyText.text1(item, textColor: white)),
                  onChanged: (bool? checked) {
                    taskCubit.fillAssigneesList(
                        checked, assignees![item]!);
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
          onPressed: () => NavigationService().popScreen(context),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
