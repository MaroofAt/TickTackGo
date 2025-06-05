import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/animated_dropdown.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height(context),
          width: width(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: height(context) * 0.1,
                    child: AnimatedDropdown(
                      const ['first', 'second'],
                      'first',
                      height: height(context) * 0.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
