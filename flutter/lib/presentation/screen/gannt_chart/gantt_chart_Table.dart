import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/tasks/task_gannt.dart';

class GanttChart extends StatelessWidget {
  final List<Task> tasks;
  final DateTime start;
  final DateTime end;
  final double rowHeight;
  final double cellWidth;
  final bool showToday;

  const GanttChart({
    super.key,
    required this.tasks,
    required this.start,
    required this.end,
    this.rowHeight = 40,
    this.cellWidth = 40,
    this.showToday = true,
  });

  int get totalDays => end.difference(start).inDays + 1;
  int dayIndex(DateTime d) => d.difference(start).inDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 التواريخ بالأعلى
        Row(
          children: [
            // مساحة أسماء المهام
            Container(
              width: 120,
              height: 40,
              alignment: Alignment.center,
              child: const Text("التاريخ", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            // الأيام
            Expanded(
              child: Row(
                children: List.generate(totalDays, (i) {
                  final date = start.add(Duration(days: i));
                  return Container(
                    width: cellWidth,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey.shade300),
                        bottom: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    child: Text(
                      "${date.day}/${date.month}", // مثلا 26/8
                      style: const TextStyle(fontSize: 11),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),

        // 🔹 بعد الهيدر، نرسم الـ Tasks
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final left = dayIndex(task.start) * cellWidth;
              final width = (dayIndex(task.end) - dayIndex(task.start) + 1) * cellWidth;

              return SizedBox(
                height: rowHeight,
                child: Row(
                  children: [
                    // اسم المهمة
                    Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerLeft,
                      child: Text(task.name),
                    ),

                    // الشريط الزمني
                    Expanded(
                      child: Stack(
                        children: [
                          Row(
                            children: List.generate(totalDays, (i) {
                              return Container(
                                width: cellWidth,
                                height: rowHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.grey.shade200),
                                    bottom: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                              );
                            }),
                          ),
                          Positioned(
                            left: left,
                            top: 5,
                            child: _TaskBar(
                              width: width,
                              height: rowHeight - 10,
                              color: task.color,
                              progress: task.progress,
                            ),
                          ),
                          if (showToday)
                            _TodayMarker(
                              x: dayIndex(DateTime.now()) * cellWidth.toDouble(),
                              height: rowHeight,
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
    );


  }
}
class _TaskBar extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double progress; // 0..1

  const _TaskBar({
    required this.width,
    required this.height,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    final clamped = progress.clamp(0.0, 1.0);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: borderRadius,
        border: Border.all(color: color.withOpacity(0.7)),
      ),
      child: FractionallySizedBox(
        widthFactor: clamped,
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}

class _TodayMarker extends StatelessWidget {
  final double x;
  final double height;

  const _TodayMarker({required this.x, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: 0,
      bottom: 0,
      child: Container(
        width: 2,
        height: height,
        color: Colors.redAccent,
      ),
    );
  }
}