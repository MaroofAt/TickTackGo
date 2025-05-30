import 'package:flutter/material.dart';
import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/presentation/screen/onbording/splash_screen.dart';
import 'package:pr1/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      routes: routes,
      home: const SplashScreen(),
    );
  }
}
