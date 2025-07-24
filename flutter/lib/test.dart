import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dividerTheme: const DividerThemeData(
          thickness: 1,
          space: 1,
          color: Color(0xFFE0E0E0),
        ),
      ),
      home: const StatusPage(),
    );
  }
}

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Main content (scrollable)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Section
                  _buildSection(
                    title: 'Status',
                    children: [
                      _buildCheckboxItem('On Progress', checked: false),
                      _buildCheckboxItem(
                        'Due date',
                        checked: true,
                        trailing: const Text('5 March 2024'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Assignee Section
                  _buildSection(
                    title: 'Assignee',
                    children: [
                      _buildCheckboxItem('Calum Tyler', checked: false),
                      _buildCheckboxItem('Dawson Tarman', checked: true),
                      _buildCheckboxItem('India', checked: true),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tags Section
                  _buildSection(
                    title: 'Tags',
                    children: [
                      _buildCheckboxItem('Dashboard', checked: false),
                      _buildCheckboxItem('Medium', checked: true),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description Section
                  _buildSection(
                    title: 'Description',
                    children: [
                      const Text(
                        'This page aims to provide real-time insights into employee performance metrics and key business indicators.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  const Divider(),
                  const SizedBox(height: 16),

                  // Attachments Section
                  _buildSection(
                    title: 'Attachment (2)',
                    children: [
                      _buildAttachmentItem('Design brief.pdf', '1.3 MB'),
                      _buildAttachmentItem('Comments', null),
                      _buildAttachmentItem('Craftboard logo.al', '2.5 MB'),
                      _buildAttachmentItem('Download', null),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom tab section
          _buildBottomTabSection(),
        ],
      ),
    );
  }

  Widget _buildBottomTabSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'Subtasks'),
                Tab(text: 'Comments'),
                Tab(text: 'Activities'),
              ],
            ),
            SizedBox(
              height: 200, // Adjust height as needed
              child: TabBarView(
                children: [
                  // Subtasks Tab
                  _buildSubtasksTab(),
                  // Comments Tab
                  _buildCommentsTab(),
                  // Activities Tab
                  _buildActivitiesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtasksTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Design Process',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildCheckboxItem(
            'Understanding client design brief',
            checked: false,
            trailing: const Text('2/4'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 4),
            child: InkWell(
              onTap: () {},
              child: const Text(
                'Blocker: The brief from client was not clear so it took time to understand it.',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildCheckboxItem(
            'Collect moodboards about KPI programs',
            checked: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsTab() {
    return const Center(
      child: Text('Comments content goes here'),
    );
  }

  Widget _buildActivitiesTab() {
    return const Center(
      child: Text('Activities content goes here'),
    );
  }

  // Reusable widget methods from previous implementation
  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildCheckboxItem(String text,
      {bool checked = false, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: (value) {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Expanded(child: Text(text)),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(String name, String? size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                if (size != null)
                  Text(
                    size,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, size: 16),
        ],
      ),
    );
  }
}