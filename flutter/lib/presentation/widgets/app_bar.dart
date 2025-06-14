import 'package:flutter/material.dart';

class MyAppBar {
  static appBar(BuildContext context,
      {Widget? title,
      Widget? leading,
      Color? backgroundColor,
      bool? centerTitle,
      List<Widget>? actions,
      Color? foregroundColor}) {
    return AppBar(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      centerTitle: centerTitle?? true,
      title: title,
      titleTextStyle: TextStyle(color: foregroundColor, fontSize: 20),
      leading: leading,
      foregroundColor: foregroundColor??Theme.of(context).primaryColor,
      actions: actions,
    );
  }
}
