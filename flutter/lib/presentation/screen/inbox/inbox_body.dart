import 'package:flutter/material.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/screen/inbox/inbox_tasks_list.dart';

// ignore: must_be_immutable
class InboxBody extends StatelessWidget {
  List<List<InboxTasksModel>> allInboxTasks;

  InboxBody(this.allInboxTasks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TabBarView(
        children: List.generate(
          allInboxTasks.length,
              (index) {
            return InboxTasksList(allInboxTasks[index]);
          },
        ),
      ),
    );
  }
}
