import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Task {
  final String name;
  final DateTime start;
  final DateTime end;
  final Color color;

  Task({
    required this.name,
    required this.start,
    required this.end,
    this.color = Colors.blue,
  });
}

class MyApptest extends StatelessWidget {

  final List<Task> tasks = [
  Task(
  name: 'Task 1',
  start: DateTime(2025, 8, 26),
  end: DateTime(2025, 8, 28),
  color: Colors.green,
  ),
  Task(
  name: 'Task 2',
  start: DateTime(2025, 8, 27),
  end: DateTime(2025, 8, 29),
  color: Colors.blue,
  ),
  Task(
  name: 'Task 3',
  start: DateTime(2025, 8, 30),
  end: DateTime(2025, 9, 1),
  color: Colors.orange,
  ),
    Task(
      name: 'Task 3',
      start: DateTime(2025, 8, 30),
      end: DateTime(2025, 9, 1),
      color: Colors.orange,
    ),
  ];

  // توليد قائمة الأيام بين أول وأخر تاريخ
  List<DateTime> generateDaysRange(DateTime start, DateTime end) {
  List<DateTime> days = [];
  DateTime current = start;
  while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
  days.add(current);
  current = current.add(Duration(days: 1));
  }
  return days;
  }

  @override
  Widget build(BuildContext context) {
  // تحديد أقدم تاريخ وأحدث تاريخ بين كل المهام
  final DateTime minDate = tasks.map((t) => t.start).reduce((a, b) => a.isBefore(b) ? a : b);
  final DateTime maxDate = tasks.map((t) => t.end).reduce((a, b) => a.isAfter(b) ? a : b);

  final daysRange = generateDaysRange(minDate, maxDate);
  final dateFormat = DateFormat('dd MMM'); // Ex: 26 Aug

  return MaterialApp(
  home: Scaffold(
  appBar: AppBar(title: Text("Gantt by Days")),
  body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  // 👇 الخط الزمني
  Container(
  height: 40,
  color: Colors.grey[200],
  child: Row(
  children: daysRange.map((day) {
  return Expanded(
  child: Center(
  child: Text(dateFormat.format(day),
  style: TextStyle(fontWeight: FontWeight.bold)),
  ),
  );
  }).toList(),
  ),
  ),
  Divider(height: 1, color: Colors.black),
  // 👇 المهام
  Expanded(
  child: ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
  final task = tasks[index];
  final int startOffset =
  task.start.difference(minDate).inDays;
  final int taskDuration =
  task.end.difference(task.start).inDays + 1;

  return Padding(
  padding: const EdgeInsets.symmetric(
  vertical: 12.0, horizontal: 16),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(task.name,
  style: TextStyle(fontWeight: FontWeight.bold)),
  SizedBox(height: 6),
  Container(
  height: 25,
  child: Row(
  children: [
  // الفراغ قبل بداية المهمة
  for (int i = 0; i < startOffset; i++)
  Expanded(child: Container()),
  // شريط المهمة
  for (int i = 0; i < taskDuration; i++)
  Expanded(
  child: Container(
  margin:
  EdgeInsets.symmetric(horizontal: 1),
  color: task.color,
  ),
  ),
  ],
  ),
  ),
  ],
  ),
  );
  },
  ),
  ),
  ],
  ),
  ),
  );
  }
  }