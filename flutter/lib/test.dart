import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SectionsPage(),
    );
  }
}

class SectionsPage extends StatelessWidget {
  const SectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two sections
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sections Example"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Section 1"),
              Tab(text: "Section 2"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SectionList(title: "Section 1", items: ["Item A", "Item B", "Item C"]),
            SectionList(title: "Section 2", items: ["Item X", "Item Y", "Item Z"]),
          ],
        ),
      ),
    );
  }
}

class SectionList extends StatelessWidget {
  final String title;
  final List<String> items;

  const SectionList({Key? key, required this.title, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(items[index]),
          ),
        );
      },
    );
  }
}
