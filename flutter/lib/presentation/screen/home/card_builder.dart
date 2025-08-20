import 'package:flutter/material.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CardBuilder extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final Function() onTap;
  final bool withShimmer;
  final Color? shimmerColor;

  const CardBuilder({
    super.key,
    required this.color,
    required this.label,
    required this.icon,
    required this.withShimmer,
    required this.onTap,
    this.shimmerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyGestureDetector.gestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: withShimmer
              ? Shimmer(color: shimmerColor!, child: buildRow(context))
              : buildRow(context),
        ),
      ),
    );
  }

  Row buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            MyText.text1(
              label,
              textColor: Theme.of(context).scaffoldBackgroundColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),

          ],
        ),
        MyIcons.icon(icon,
            color: Theme.of(context).scaffoldBackgroundColor, size: 20),
      ],
    );
  }
}
