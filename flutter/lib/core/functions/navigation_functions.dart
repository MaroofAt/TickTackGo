import 'package:flutter/material.dart';

pushScreen(BuildContext context, Widget secondScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => secondScreen),
  );
}

pushReplacementScreen(BuildContext context, Widget secondScreen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => secondScreen),
  );
}

pushReplacementNamed(BuildContext context, String route) {
  Navigator.of(context).pushReplacementNamed(route);
}

pushNamed(BuildContext context, String route, {Object? args}) {
  Navigator.pushNamed(context, route, arguments: args);
}

pushNamedAndRemoveUntil(BuildContext context, String route) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    (route) => false,
  );
}

popScreen(BuildContext context, [Object? result]) {
  Navigator.pop(context, result);
}

popUntil(BuildContext context, String routes) {
  Navigator.popUntil(context, ModalRoute.withName(routes));
}
