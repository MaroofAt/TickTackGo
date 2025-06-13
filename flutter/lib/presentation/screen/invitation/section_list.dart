import 'package:flutter/material.dart';
import 'package:pr1/presentation/widgets/text.dart';

class SectionList extends StatelessWidget {
  final String title;
  final List<String> items;

  const SectionList({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: MyText.text1(items[index]),
          ),
        );
      },
    );
  }
}
