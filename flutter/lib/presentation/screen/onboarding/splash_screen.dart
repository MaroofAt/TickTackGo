import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    wait();
  }

  Future<void> wait() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      _visible = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    pushReplacementNamed(context, onboardingMainRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Center(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: AnimatedScale(
              scale: _visible ? 1.0 : 0.5,
              duration: const Duration(seconds: 2),
              child: MyImages.assetImage(splashScreenLogoPath),
            ),
          ),
        ),
      ),
    );
  }
}
