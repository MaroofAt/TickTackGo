import 'package:flutter/material.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/screen/inbox/first_stack_child.dart';
import 'package:pr1/presentation/screen/inbox/task_list.dart';

class InboxBody extends StatelessWidget {
  List<List<InboxTasksModel>> allInboxTasks;

  InboxBody(this.allInboxTasks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FirstStackChild(allInboxTasks),
      ],
    );
  }
}
