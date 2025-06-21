import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';

class SecondStackChild extends StatelessWidget {
  const SecondStackChild({super.key});

  @override
  Widget build(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: height(context) * 0.08,
        width: width(context),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: lightGrey.withAlpha(50),
              offset: const Offset(2, 2),
              blurRadius: 5,
              spreadRadius: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
