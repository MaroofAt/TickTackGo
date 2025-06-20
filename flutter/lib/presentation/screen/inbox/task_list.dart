import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class TaskList extends StatelessWidget {
  List<InboxTasksModel> inboxList;

  TaskList(this.inboxList, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: inboxList.length,
      itemBuilder: (context, index) {
        InboxTasksModel inboxTasks = inboxList[index];
        return TaskCard(inboxTasks);
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  InboxTasksModel inboxTasks;

  TaskCard(
    this.inboxTasks, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: lightGrey.withAlpha(50),
            offset: const Offset(2, 2),
            blurRadius: 5,
            spreadRadius: 2.5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Colors.grey),
            const SizedBox(width: 8),
            MyText.text1(inboxTasks.title,
                textColor: white, fontWeight: FontWeight.bold),
            const Spacer(),
            SizedBox(
              width: width(context) * 0.3,
              child: MyText.text1(
                inboxTasks.description,
                textColor: white,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            MyIcons.icon(Icons.arrow_circle_down,color: white)
          ],
        ),
      ),
    );
  }
}
