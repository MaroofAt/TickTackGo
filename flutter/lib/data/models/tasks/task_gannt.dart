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
    name: task.title,
    start: task.startDate ?? DateTime.now(),
    end: task.dueDate ?? DateTime.now().add(const Duration(days: 1)),
    progress: (task.completeDate != null) ? 1.0 : 0.3,
    color: task.outDated ? Colors.red : Colors.green,
  );
}