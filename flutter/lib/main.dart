import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/business_logic/comment_cubit.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/business_logic/splash_cubit/splash_cubit.dart';
import 'package:pr1/core/API/comments.dart';
import 'package:pr1/core/API/issues.dart';
import 'package:pr1/core/constance/routes.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/deep_link_service.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/firebase_options.dart';
import 'package:pr1/themes/themes.dart';

import 'business_logic/replay/replay_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appRouter = AppRouter();
  final deepLinkService = DeepLinkService(appRouter);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize deep link service after app starts
  Future.delayed(Duration.zero, () {
    deepLinkService.initialize();
  });
  runApp(MyApp(appRouter: appRouter, deepLinkService: deepLinkService));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  final DeepLinkService deepLinkService;

  const MyApp(
      {required this.appRouter, required this.deepLinkService, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupDeepLink();
  }

  Future<void> _setupDeepLink() async {
    _appLinks.uriLinkStream.listen(
      (Uri? uri) {
        if (uri != null) {
          DeepLinkService(widget.appRouter).handleDeepLink(uri);
        }
      },
    ).onError((e) {
      NavigationService().pushReplacement(context, splashScreenRoute);
    });

    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        DeepLinkService(widget.appRouter).handleDeepLink(initialLink);
      }
    } catch (e) {
      if (!mounted) return;
      NavigationService().pushReplacement(context, splashScreenRoute);
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
        routerConfig: widget.appRouter.router,
      ),
    );
  }
}
