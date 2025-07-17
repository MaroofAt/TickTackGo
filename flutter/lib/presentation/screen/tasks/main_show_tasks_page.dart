import 'package:flutter/material.dart';
import 'package:pr1/presentation/screen/tasks/show_tasks_app_bar.dart';

class MainShowTasksPage extends StatelessWidget {
  const MainShowTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowTasksAppBar.showTasksAppBar(context),
      
    );
  }
}
