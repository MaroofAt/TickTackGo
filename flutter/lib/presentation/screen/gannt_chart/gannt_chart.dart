// import 'package:flutter/cupertino.dart';
//
// import '../../../data/models/tasks/create_task_model.dart';
// import '../../../data/models/tasks/task_gannt.dart';
// import 'gantt_chart_Table.dart';
//
// class GanttChartPage extends StatelessWidget {
//   GanttChartPage({super.key});
//
//   final List<CreateTaskModel> myTasks = [
//     CreateTaskModel(
//       id: 1,
//       title: "تحليل المتطلبات",
//       description: "تحليل المشروع",
//       startDate: DateTime(2025, 8, 20),
//       dueDate: DateTime(2025, 8, 28),
//       completeDate: null,
//       creator: 1,
//       workspace: 1,
//       project: 1,
//       image: "",
//       outDated: false,
//       parentTask: null,
//       assignees: [],
//       status: "in_progress",
//       priority: "high",
//       locked: false,
//       reminder: null,
//       errorMessage: "",
//     ),
//     CreateTaskModel(
//       id: 2,
//       title: "التصميم",
//       description: "تصميم النظام",
//       startDate: DateTime(2025, 8, 26),
//       dueDate: DateTime(2025, 9, 5),
//       completeDate: null,
//       creator: 1,
//       workspace: 1,
//       project: 1,
//       image: "",
//       outDated: false,
//       parentTask: null,
//       assignees: [],
//       status: "not_started",
//       priority: "medium",
//       locked: false,
//       reminder: null,
//       errorMessage: "",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final tasks = myTasks.map(convertToTask).toList();
//
//     final start = tasks.map((t) => t.start).reduce((a, b) => a.isBefore(b) ? a : b);
//     final end = tasks.map((t) => t.end).reduce((a, b) => a.isAfter(b) ? a : b);
//
//     return GanttChart(
//       tasks: tasks,
//       start: start,
//       end: end,
//     );
//   }
// }
