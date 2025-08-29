import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pr1/data/models/tasks/create_task_model.dart';

class Task {
  final String name;
  final DateTime start;
  final DateTime end;
  final double progress;
  final Color color;

  Task({
    required this.name,
    required this.start,
    required this.end,
    required this.progress,
    this.color = Colors.blue,
  });
}

Task convertToTask(CreateTaskModel task) {
  return Task(
    name: task.data!.title,
    start: task.data!.startDate ?? DateTime.now(),
    end: task.data!.dueDate ?? DateTime.now().add(const Duration(days: 1)),
    progress: (task.data!.completeDate != null) ? 1.0 : 0.3,
    color: task.data!.outDated ? Colors.red : Colors.green,
  );
}