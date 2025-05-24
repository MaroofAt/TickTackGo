import 'package:flutter/material.dart';

Widget buildPage({
    required Color color,
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
      color: color,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ));}