import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

pushReplacementNamed(BuildContext context, String route) {
  GoRouter.of(context).go(route);
}

pushNamed(BuildContext context, String route, {Map<String, dynamic>? args}) {
  GoRouter.of(context).pushNamed(route,queryParameters: args ?? {});
}

pushNamedAndRemoveUntil(BuildContext context, String route) {
  GoRouter.of(context).go(route);
}

popScreen(BuildContext context, [Object? result]) {
  GoRouter.of(context).pop();
}
