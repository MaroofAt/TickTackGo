import 'package:flutter/material.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/auth/signin.dart';
import 'package:pr1/presentation/screen/auth/signup.dart';
Map<String, Widget Function(BuildContext)> routes = {
signupRoute: (context) => SignUp(),
signinRoute:(context) => SignIn()

};

