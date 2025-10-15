import 'dart:async';

import 'package:app_links/app_links.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();
  final AppRouter _appRouter = AppRouter();
  StreamSubscription<Uri>? _linkSubscription;
  @override
  void initState() {
    super.initState();
    // Handle the initial link that launched the app
    _handleInitialUri();
    // Handle links that are received while the app is running
    _handleIncomingLinks();
  }


  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  // UPDATED for app_links
  Future<void> _handleInitialUri() async {
    try {
      print('********************************');
      print(_appLinks.getInitialLink());
      final uri = await _appLinks.getInitialLink(); // Use getInitialLink()
      if (uri != null) {
        // Use the router to navigate. The path includes the leading '/'
        _appRouter.router.go(uri.path);
      }
    } catch (e) {
      // An error occurred, maybe log it
      debugPrint('Failed to get initial URI: $e');
    }
  }

  // UPDATED for app_links
  void _handleIncomingLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) { // The stream provides non-nullable URIs
      // Use the router to navigate
      _appRouter.router.go(uri.path);
    }, onError: (err) {
      debugPrint('Got error listening to incoming links: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CommentCubit(CommentApi())),
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
        routerConfig: _appRouter.router,
      ),
    );
  }
}
