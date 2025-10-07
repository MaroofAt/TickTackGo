import 'package:flutter/material.dart';
import 'package:gantt_view/gantt_view.dart';

import '../../../core/constance/colors.dart';
import '../../../core/functions/navigation_functions.dart';
import '../../../data/models/tasks/fetch_tasks_model.dart';

class TasksGanttChart extends StatefulWidget {
  const TasksGanttChart({super.key});

  @override
  State<TasksGanttChart> createState() => _TasksGanttChartState();
}

class _TasksGanttChartState extends State<TasksGanttChart> {
  List<FetchTasksModel>? tasks;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    tasks = args['tasks'];
  }

  @override
  Widget build(BuildContext context) {
    final valid = tasks!
        .where((t) => t.startDate != null && t.dueDate != null)
        .toList()
      ..sort((a, b) => a.startDate!.compareTo(b.startDate!));

    final rows = <GridRow>[];
    if (valid.isNotEmpty) {
      rows.add(ActivityGridRow('Tasks'));
      for (final t in valid) {
        rows.add(TaskGridRow<FetchTasksModel>(
          data: t,
          startDate: t.startDate!,
          endDate: t.dueDate!,
          tooltip: '${t.title}\n${_fmt(t.startDate!)} - ${_fmt(t.dueDate!)}',
        ));
      }
    }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
              onPressed: () => popScreen(context),
              icon: const Icon(Icons.arrow_back_sharp, color: white)),
          title: const Center(
              child: Text('Gantt Chart',
                  style: TextStyle(
                      color: white, fontSize: 20, fontFamily: 'PTSerif')))),
      body: valid.isEmpty
          ? const Center(child: Text('no tasks here!'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GanttChart<FetchTasksModel>(
                rows: rows,
                showCurrentDate: true,
                style: GanttStyle(
                  timelineAxisType: TimelineAxisType.daily, // Daily/weekly
                  showYear: true,
                  showMonth: true,
                  showDay: true,
                  columnWidth: 40,
                  gridColor: Colors.grey.shade300,
                  weekendColor: Colors.transparent,
                  axisDividerColor: Colors.grey.shade500,
                  snapToDay: false,
                  labelColumnWidth: 100,
                  activityLabelColor: Colors.blueGrey.shade700,
                  taskLabelColor: primaryColor,
                  dayLabelBuilder: (day) => Text(
                    '$day',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  monthLabelBuilder: (month) => Center(
                    child: Text(
                      ' $month',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  yearLabelBuilder: (year) => Text(
                    '/$year/',
                    style: const TextStyle(color: Colors.white),
                  ),

                  barHeight: 24,
                  taskBarRadius: 8,
                  taskBarColor: parrotGreen,
                  taskLabelBuilder: (taskRow) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      taskRow.data.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // شكل عنوان المجموعة (Activity row)
                  // activityLabelBuilder: (activity) => Padding(
                  //   padding: const EdgeInsets.all(6.0),
                  //   child: Text(
                  //     activity.label ?? '',
                  //     style: const TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),

                  // ألوان التولتيب (اختياري)
                  // tooltipColor: white,
                  // tooltipPadding:
                  // const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                // خطوط مرجعية على التواريخ (اليوم مثلاً)
                // dateLines: [
                //   GanttDateLine(
                //     date: DateTime.now(),
                //     width: 2,
                //     color: Colors.redAccent,
                //   ),
                // ],
              ),
            ),
    );
  }

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
}
