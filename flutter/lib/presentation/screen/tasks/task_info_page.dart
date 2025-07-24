import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/screen/tasks/task_info_app_bar.dart';
import 'package:pr1/presentation/widgets/circle.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class TaskInfoPage extends StatelessWidget {
  final FetchTasksModel fetchTasksModel;

  const TaskInfoPage(this.fetchTasksModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskInfoAppBar.taskInfoAppBar(context, fetchTasksModel.title),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              MyCircle.circle(width(context) * 0.35, color: Colors.white),
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
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: Scrollbar(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          MyText.text1(
                            fetchTasksModel.description,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 20,
                children: [
                  buildTwoTextRow(
                    context,
                    ' Status',
                    ' ${fetchTasksModel.status}',
                    Icons.access_time,
                    white,
                    Icons.circle_outlined,
                  ),
                  buildTwoTextRow(
                    context,
                    ' Due Date',
                    ' ${DateFormat('yyyy-MM-d').format(fetchTasksModel.dueDate!)}',
                    Icons.date_range,
                    white,
                  ),
                  buildTwoTextRow(
                    context,
                    ' Assignees',
                    //TODO assignees people
                    ' ${DateFormat('yyyy-MM-d').format(fetchTasksModel.dueDate!)}',
                    Icons.people,
                    white,
                  ),
                  buildTwoTextRow(
                    context,
                    ' Priority',
                    ' ${fetchTasksModel.priority}',
                    Icons.people,
                    white,
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
                          _buildCommentsTab(),
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
      spacing: width(context) * 0.1,
      children: [
        buildIconTextRow(firstLabel, firstIcon),
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

  Widget _buildCommentsTab() {
    return Center(
      child: MyText.text1('Comments content goes here', textColor: white),
    );
  }
}
