import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(child: Text('$userId')), // Replace with avatar if available
        title: Text(title),
        subtitle: Text('Points: $points'),
      ),
    );
  }
}
