import 'package:flutter/material.dart';

class MotivationalSection extends StatelessWidget {
  const MotivationalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'Stay Productive',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Motivational Quote Card
          Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.format_quote, color: Colors.amberAccent, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Focus on what matters most.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Productivity Tip Card
          Card(
            color: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.lightBlueAccent, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Try the Pomodoro technique today!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Motivational Quote Card
          Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.format_quote, color: Colors.amberAccent, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'The secret of getting ahead is getting started.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
