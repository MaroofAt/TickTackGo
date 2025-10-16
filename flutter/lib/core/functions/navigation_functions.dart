import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

pushReplacementNamed(BuildContext context, String route, [Object? extra]) {
  GoRouter.of(context).goNamed(route);
}

pushReplacement(BuildContext context, String route, [Object? extra]) {
  GoRouter.of(context).pushReplacement(route, extra: extra);
}

Future<dynamic> pushNamed(BuildContext context, String route,
    {Map<String, dynamic>? args}) async {
  return await GoRouter.of(context)
      .pushNamed(route, queryParameters: args ?? {});
}

push(BuildContext context, String route, {Map<String, dynamic>? args}) {
  GoRouter.of(context).push(route, extra: args);
}

popScreen(BuildContext context, [Object? result]) {
  GoRouter.of(context).pop(result);
}
