import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final NavigationService _navigationService =
      NavigationService._internal();

  factory NavigationService() {
    return _navigationService;
  }

  NavigationService._internal();

  void pushReplacementNamed(BuildContext context, String route, [Object? extra]) {
    GoRouter.of(context).goNamed(route);
  }

  Future<dynamic> pushReplacement(BuildContext context, String route, [Object? extra]) async {
    return await GoRouter.of(context).pushReplacement(route, extra: extra);
  }

  Future<dynamic> pushNamed(BuildContext context, String route,
      {Map<String, dynamic>? args}) async {
    return await GoRouter.of(context)
        .pushNamed(route, queryParameters: args ?? {});
  }

  Future<dynamic> push(BuildContext context, String route, {Map<String, dynamic>? args}) async {
    return await GoRouter.of(context).push(route, extra: args);
  }

  void popScreen(BuildContext context, [Object? result]) {
    GoRouter.of(context).pop(result);
  }
}
