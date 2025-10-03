import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';

class TaskModel {
  int id;
  String title;
  String description;
  DateTime? startDate;
  DateTime? dueDate;
  dynamic completeDate;
  String image;
  bool outDated;
  int projectId;
  dynamic parentTask;
  List<String> assignees;
  String status;
  String priority;
  bool locked;
  dynamic reminder;
  List<SubTask> subTasks;
  String statusMessage;
  String errorMessage;
  List<AttachmentsDisplayModel> attachments;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.startDate,
      required this.dueDate,
      required this.completeDate,
      required this.image,
      required this.outDated,
      required this.parentTask,
      required this.assignees,
      required this.status,
      required this.priority,
      required this.locked,
      required this.reminder,
      required this.subTasks,
      required this.statusMessage,
      required this.projectId,
      required this.attachments,
      required this.errorMessage});
}
