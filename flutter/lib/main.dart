import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/business_logic/splash_cubit/splash_cubit.dart';
import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/presentation/screen/auth/signinnew.dart';
import 'package:pr1/presentation/screen/home/main_home_page.dart';
import 'package:pr1/presentation/screen/issues/all_issues.dart';
import 'package:pr1/presentation/screen/onboarding/splash_screen.dart';
import 'package:pr1/themes/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(DevicePreview(builder: (context) => MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: theme(),
      // theme: ThemeData.dark(),
      routes: routes,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => SplashCubit()),
        ],
        child: const Signinnew(),
      ),
    );
  }
}
