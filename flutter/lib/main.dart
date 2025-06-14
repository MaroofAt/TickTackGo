import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/presentation/screen/home/main_home_page.dart';
import 'package:pr1/presentation/screen/onboarding/onboarding_main.dart';
import 'package:pr1/presentation/screen/onboarding/splash_screen.dart';
import 'package:pr1/presentation/screen/workspace/create_workspace_page.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_page.dart';
import 'package:pr1/themes/themes.dart';

void main() {
  // runApp(DevicePreview(builder: (context) => MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: theme(),
      routes: routes,
      home: BlocProvider(
        create: (context) => WorkspaceCubit(),
        child: const MainHomePage(),
      ),
    );
  }
}
