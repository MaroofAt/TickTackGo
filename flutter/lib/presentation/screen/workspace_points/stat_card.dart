import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class StatCard extends StatelessWidget {
  final String title;
  final int userId;
  final int points;

  const StatCard({
    super.key,
    required this.title,
    required this.userId,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: width(context) * 0.08,
          child: MyIcons.icon(Icons.person, size: width(context) * 0.1),
        ),
        title: MyText.text1(title, textColor: white),
        subtitle: MyText.text1('Points: $points', textColor: white),
      ),
    );
  }
}
