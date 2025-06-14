import 'package:flutter/material.dart';
import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/presentation/screen/home/main_home_page.dart';
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
