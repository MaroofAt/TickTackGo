import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/presentation/screen/auth/signin.dart';
import 'package:pr1/presentation/screen/auth/signinnew.dart';
import 'package:pr1/presentation/screen/auth/signupnew.dart';
import 'package:pr1/presentation/screen/onboarding/splash_screen.dart';
import 'package:pr1/presentation/screen/projects/creat_project.dart';
import 'package:pr1/presentation/screen/projects/show_projects.dart';
import 'package:pr1/themes/themes.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: theme(),
      routes: routes,
      home: const CreatProject(),
    );
  }
}
