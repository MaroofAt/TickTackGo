import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pr1/business_logic/comment_cubit.dart';
import 'package:pr1/business_logic/comment_cubit.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/comments/comment.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/tasks/task_info_app_bar.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/circle.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

import '../../../core/API/comments.dart';
class TaskInfoPage extends StatefulWidget {
  final FetchTasksModel fetchTasksModel;

  const TaskInfoPage(this.fetchTasksModel, {Key? key}) : super(key: key);

  @override
  _TaskInfoPageState createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage> {
  @override
  void initState() {
    super.initState();
    context.read<CommentCubit>().fetchComments(widget.fetchTasksModel.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskInfoAppBar.taskInfoAppBar(context, widget.fetchTasksModel.title),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width(context) * 0.35,
                child: MyImages.networkImage(fetchTasksModel.image),
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
                      border: Border.all(color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                    child: Scrollbar(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          MyText.text1(
                            widget.fetchTasksModel.description,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildTwoTextRow(
                        context,
                        ' Status',
                        ' ${widget.fetchTasksModel.status}',
                        Icons.access_time,
                        white,
                        Icons.circle_outlined,
                      ),
                      MyGestureDetector.gestureDetector(
                        onTap: () {
                          if (widget.fetchTasksModel.status == 'in_progress') {
                            // BlocProvider.of<TaskCubit>(context).completeTask();
                          }
                        },
                        child: Container(
                          height: height(context) * 0.05,
                          width: width(context) * 0.28,
                          decoration: BoxDecoration(
                              color: widget.fetchTasksModel.status == 'pending'
                                  ? lightGrey
                                  : Theme
                                  .of(context)
                                  .secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: MyText.text1('Completed?',
                                textColor: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildTwoTextRow(
                    context,
                    ' Due Date',
                    ' ${DateFormat('yyyy-MM-d').format(
                       widget. fetchTasksModel.dueDate!)}',
                    Icons.date_range,
                    white,
                  ),
                  // buildTwoTextRow(
                  //   context,
                  //   ' Assignees',
                  //   //TODO assignees people
                  //   ' ${DateFormat('yyyy-MM-d').format(fetchTasksModel.dueDate!)}',
                  //   Icons.people,
                  //   white,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildTwoTextRow(
                        context,
                        ' Priority',
                        ' ${widget.fetchTasksModel.priority}',
                        Icons.people,
                        white,
                      ),
                      MyGestureDetector.gestureDetector(
                        onTap: () {
                          BlocProvider.of<TaskCubit>(context).cancelTask(
                              widget. fetchTasksModel.id);
                        },
                        child: Container(
                          height: height(context) * 0.05,
                          width: width(context) * 0.28,
                          decoration: BoxDecoration(
                              color: widget.fetchTasksModel.status == 'completed'
                                  ? lightGrey
                                  : Theme
                                  .of(context)
                                  .secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: MyText.text1('Cancel?',
                                textColor: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blue,
                      tabs: [
                        Tab(text: 'Subtasks'),
                        Tab(text: 'Comments'),
                      ],
                    ),
                    SizedBox(
                      height: 200, // Adjust height as needed
                      child: TabBarView(
                        children: [
                          // Subtasks Tab
                          _buildSubtasksTab(),
                          // Comments Tab
                          BlocBuilder<CommentCubit, CommentState>(
                            builder: (context, comments) {
                              return _buildCommentsTab(comments,context);
                            },
                          ),
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

  Widget _buildSubtasksTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Design Process',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 4),
            child: InkWell(
              onTap: () {},
              child: const Text(
                'Blocker: The brief from client was not clear so it took time to understand it.',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCommentsTab(CommentState state, BuildContext context) {
    final TextEditingController _commentController = TextEditingController();

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
                        SizedBox(height: 5,),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
                            decoration: BoxDecoration(
                              color: parrotGreen,
                              borderRadius: const BorderRadius.only(
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
    ,child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
                  final text = _commentController.text.trim();
                  if (text.isNotEmpty) {
                    BlocProvider.of<CommentCubit>(context).addComment(
                      widget.fetchTasksModel.id,
                      text,
                    );
                    _commentController.clear();
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