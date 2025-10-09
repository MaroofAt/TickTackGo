import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/business_logic/comment_cubit.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/business_logic/splash_cubit/splash_cubit.dart';
import 'package:pr1/core/API/comments.dart';
import 'package:pr1/core/API/issues.dart';
import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/presentation/screen/onboarding/splash_screen.dart';
import 'package:pr1/themes/themes.dart';
import 'business_logic/replay/replay_cubit.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await  initOneSignal()
  // await NotificationApi().getDeviceToken();
  // await NotificationHandel().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CommentCubit(Commentapi())),
        BlocProvider(create: (context) => IssuesCubit(IssueApi())),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (_) => ReplyCubit(IssueApi())),
      ],
      child: MaterialApp.router(
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: theme(),
        // theme: ThemeData.dark(),
        // routes: routes,
        // home: const SplashScreen(),
        routerConfig: AppRouter().router,
      ),
    );
  }
}
