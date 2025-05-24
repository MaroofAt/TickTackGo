import 'package:flutter/material.dart';

class Sign_in {
  Future<Object?> customSigninDialog(BuildContext context,
    {required ValueChanged onCLosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    // TODO: Custom transition
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 620,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  // TODO: Sign in text and decsription

                  // TODO: Sign in form

                  // TODO: Divider

                  // TODO: Socal login
                ],
              ),
              // TODO: Close button
            ],
          ),
        ),
      ),
    ),
  ).then(onCLosed);
}
}