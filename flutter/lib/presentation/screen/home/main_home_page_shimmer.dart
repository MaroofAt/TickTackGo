import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/home/card_builder.dart';
import 'package:pr1/presentation/screen/home/task_card.dart';
import 'package:pr1/presentation/screen/home/task_card_shimmer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MainHomePageShimmer extends StatelessWidget {
  const MainHomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: width(context) * 0.1,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            CardBuilder(
              color: lightGrey,
              label: workspaceText,
              icon: Icons.work,
              onTap: () {},
              withShimmer: true,
              shimmerColor: black,
            ),
            CardBuilder(
              color: lightGrey,
              label: invitesText,
              icon: Icons.auto_awesome,
              onTap: () {},
              withShimmer: true,
              shimmerColor: black,
            ),
          ],
        ),
        Row(
          children: [
            CardBuilder(
              color: lightGrey,
              label: inboxText,
              icon: Icons.folder_copy,
              onTap: () {},
              withShimmer: true,
              shimmerColor: black,
            ),
            CardBuilder(
              color: lightGrey,
              label: 'logout',
              icon: Icons.logout_rounded,
              onTap: () {},
              withShimmer: true,
              shimmerColor: black,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView(
            children: const [
              TaskCardShimmer(),
              TaskCardShimmer(),
              TaskCardShimmer(),
            ],
          ),
        ),
      ],
    );
  }
}
