import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pr1/business_logic/comment_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/tasks/task_model.dart';
import 'package:pr1/presentation/screen/tasks/attachments_dialog.dart';
import 'package:pr1/presentation/screen/tasks/task_info_app_bar.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class TaskInfoPage extends StatefulWidget {
  const TaskInfoPage({super.key});

  @override
  State<TaskInfoPage> createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage> {
  TaskModel? task;
  TaskCubit? taskCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    task = args['task'];
    taskCubit = args['taskCubit'];
    context.read<CommentCubit>().fetchComments(task!.id);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && result != null) {
          taskCubit!.fetchTasks(task!.projectId);

          /*
                  * remove from tasksTitles
                  * so it doesn't appear in the parent projects list
                  */
          taskCubit!.tasksTitles.removeWhere((key, value) => key == result);
        }
      },
      child: Scaffold(
        appBar: TaskInfoAppBar.taskInfoAppBar(context, task!.title),
        body: SizedBox(
          height: height(context),
          width: width(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: width(context) * 0.35,
                  height: height(context) * 0.2,
                  child: MyImages.networkImage(task!.image),
                ),
                // MyCircle.circle(width(context) * 0.35, color: Colors.white),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.text1('Task description: ',
                        fontSize: 20, textColor: white),
                    Container(
                      height: height(context) * 0.1,
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Scrollbar(
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            MyText.text1(
                              task!.description,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildTwoTextRow(
                          context,
                          ' Status',
                          ' ${task!.status}',
                          Icons.access_time,
                          white,
                          Icons.circle_outlined,
                        ),
                        BlocConsumer<TaskCubit, TaskState>(
                          listener: (context, state) {
                            if (state is TaskCompletingSucceededState) {
                              NavigationService().popScreen(context, task!.title);
                            }
                          },
                          builder: (context, state) {
                            if (state is TaskCompletingState) {
                              return Container(
                                height: height(context) * 0.05,
                                width: width(context) * 0.28,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                  child: LoadingIndicator
                                      .circularProgressIndicator(),
                                ),
                              );
                            }
                            return MyGestureDetector.gestureDetector(
                              onTap: () {
                                if (task!.status == 'in_progress' &&
                                    !task!.locked) {
                                  BlocProvider.of<TaskCubit>(context)
                                      .completeTask(task!.id);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: height(context) * 0.05,
                                width: width(context) * 0.28,
                                decoration: BoxDecoration(
                                    color:
                                        (task!.status != 'in_progress' ||
                                                task!.locked)
                                            ? lightGrey
                                            : Theme.of(context)
                                                .secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                  child: MyText.text1('Completed?',
                                      textColor: Colors.black),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildTwoTextRow(
                      context,
                      ' Due Date',
                      ' ${DateFormat('yyyy-MM-d').format(task!.dueDate!)}',
                      Icons.date_range,
                      white,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildTwoTextRow(
                          context,
                          ' Priority',
                          ' ${task!.priority}',
                          Icons.priority_high_outlined,
                          white,
                        ),
                        BlocConsumer<TaskCubit, TaskState>(
                          listener: (context, state) {
                            if (state is TaskCancelingSucceededState) {
                              NavigationService().popScreen(context, task!.title);
                            }
                          },
                          builder: (context, state) {
                            if (state is TaskCancelingState) {
                              return Container(
                                height: height(context) * 0.05,
                                width: width(context) * 0.28,
                                decoration: BoxDecoration(
                                    color: task!.status == 'completed'
                                        ? lightGrey
                                        : Theme.of(context)
                                            .secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                  child: LoadingIndicator
                                      .circularProgressIndicator(),
                                ),
                              );
                            }
                            return MyGestureDetector.gestureDetector(
                              onTap: () {
                                if (task!.status != 'completed') {
                                  BlocProvider.of<TaskCubit>(context)
                                      .cancelTask(task!.id);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: height(context) * 0.05,
                                width: width(context) * 0.28,
                                decoration: BoxDecoration(
                                    color: task!.status == 'completed'
                                        ? lightGrey
                                        : Theme.of(context)
                                            .secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                  child: MyText.text1('Cancel?',
                                      textColor: Colors.black),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width(context) * 0.4,
                          child: buildTwoTextRow(
                            context,
                            'Locked',
                            task!.locked.toString(),
                            Icons.lock,
                            white,
                          ),
                        ),
                        MyGestureDetector.gestureDetector(
                          onTap: () {
                            if (task!.attachments.isNotEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AttachmentsDialog(task!.attachments),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: width(context) * 0.4,
                            height: width(context) * 0.1,
                            decoration: BoxDecoration(
                              color: task!.attachments.isNotEmpty
                                  ? Theme.of(context).secondaryHeaderColor
                                  : lightGrey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child:
                                  MyText.text1('Attachments', textColor: black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.blue,
                        tabs: [
                          Tab(text: 'Comments'),
                          Tab(text: 'Assignees'),
                          Tab(text: 'Messages'),
                        ],
                      ),
                      SizedBox(
                        height: height(context) * 0.22,
                        child: TabBarView(
                          children: [
                            // Comments Tab
                            BlocBuilder<CommentCubit, CommentState>(
                              builder: (context, comments) {
                                return _buildCommentsTab(comments, context);
                              },
                            ),

                            // // Subtasks Tab
                            _buildAssigneesTab(),
                            _buildMessagesTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTwoTextRow(BuildContext context, String firstLabel,
      String secondLabel, IconData firstIcon, Color secondTextColor,
      [IconData? secondIcon]) {
    return Row(
      children: [
        buildIconTextRow(firstLabel, firstIcon),
        const SizedBox(width: 10),
        buildIconTextRow(secondLabel, secondIcon, secondTextColor)
      ],
    );
  }

  Row buildIconTextRow(String label, IconData? icon, [Color? secondTextColor]) {
    return Row(
      children: [
        icon != null ? MyIcons.icon(icon, color: lightGrey) : Container(),
        MyText.text1(label,
            textColor: secondTextColor ?? lightGrey, fontSize: 18),
      ],
    );
  }

  Widget _buildAssigneesTab() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: task!.assignees.length,
        itemBuilder: (context, index) {
          return Container(
            width: width(context),
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: MyText.text1(task!.assignees[index],
                  fontSize: 16, textColor: white),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessagesTab() {
    String message = task!.statusMessage.isEmpty
        ? 'No messages for this task'
        : task!.statusMessage;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 4),
            child: MyText.text1(
              message,
              textColor: ampleOrange,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsTab(CommentState state, BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: Builder(
            builder: (_) {
              if (state is CommentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CommentLoaded) {
                if (state.comments.isEmpty) {
                  return const Center(
                    child: Text(
                      "No comments yet",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return Stack(
                      children: [
                        const SizedBox(height: 5),
                        Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 5),
                          color: Colors.grey[800],
                          child: ListTile(
                            title: Text(
                              comment.body,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "By ${comment.user.username} • ${comment.createdAt.toString().split(' ')[0]}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 20,
                          child: Container(
                            width: 20,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: parrotGreen,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(400),
                                topLeft: Radius.circular(400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is CommentError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    hintText: "Write a comment...",
                    hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  final text = commentController.text.trim();
                  if (text.isNotEmpty) {
                    BlocProvider.of<CommentCubit>(context).addComment(
                      task!.id,
                      text,
                    );
                    commentController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
