import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/widgets/text.dart';

class TaskListItem extends StatelessWidget {
  final FetchTasksModel fetchTask;
  final Color color;
  const TaskListItem(this.fetchTask, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      height: height(context) * 0.12,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
        border: Border(left: BorderSide(color: color, width: 5)),
        boxShadow: [
          BoxShadow(
            color: Colors.white70.withAlpha(50),
            blurRadius: 3,
            spreadRadius: 3,
            offset: const Offset(4, 4),
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: width(context) * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Container(
                  width: width(context) * 0.2,
                  height: height(context) * 0.03,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(child: MyText.text1(fetchTask.status)),
                ),
                MyText.text1(fetchTask.title,
                    textColor: white, textAlign: TextAlign.center),
                MyText.text1(fetchTask.dueDate.toString(),
                    textColor: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
