import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/screen/inbox/task_list.dart';
import 'package:pr1/presentation/widgets/text.dart';

class FirstStackChild extends StatelessWidget {
  List<List<InboxTasksModel>> allInboxTasks;

  FirstStackChild(this.allInboxTasks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: List.generate(3, (index) {
          if (allInboxTasks[index].isEmpty) {
            return Center(
              child: MyText.text1('No tasks here ',textColor: white,fontSize: 22),
            );
          }
          return TaskList(allInboxTasks[index]);
        }),
      ),
    );
  }
}
