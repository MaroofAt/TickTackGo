import 'package:flutter/material.dart';
import '../../../data/models/tasks/fetch_tasks_model.dart';
import 'gantt_chart.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // هنا بنعمل الليست تبع المهام
    List<FetchTasksModel> myTasks = [
      FetchTasksModel(
        id: 1,
        title: "Task 1",
        description: "Description",
        startDate: DateTime(2025, 8, 20),
        dueDate: DateTime(2025, 8, 25),
        completeDate: null,
        creator: 1,
        workspace: 1,
        project: 1,
        image: '',
        outDated: false,
        parentTask: null,
        assignees: [],
        status: "in_progress",
        priority: "high",
        locked: false,
        reminder: null,
        errorMessage: '',
      ),
      FetchTasksModel(
        id: 2,
        title: "Task 2",
        description: "Description",
        startDate: DateTime(2025, 8, 24),
        dueDate: DateTime(2025, 8, 30),
        completeDate: DateTime(2025, 8, 29),
        creator: 1,
        workspace: 1,
        project: 1,
        image: '',
        outDated: false,
        parentTask: null,
        assignees: [],
        status: "done",
        priority: "medium",
        locked: false,
        reminder: null,
        errorMessage: '',
      ),
      FetchTasksModel(
        id: 2,
        title: "Task 2",
        description: "Description",
        startDate: DateTime(2025, 9, 26),
        dueDate: DateTime(2025, 9, 30),
        completeDate: DateTime(2025, 9, 29),
        creator: 1,
        workspace: 1,
        project: 1,
        image: '',
        outDated: false,
        parentTask: null,
        assignees: [],
        status: "done",
        priority: "medium",
        locked: false,
        reminder: null,
        errorMessage: '',
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gantt Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TasksGanttChart(tasks: myTasks), // هون بنستدعي الشاشة
    );
  }
}
