import 'package:flutter/material.dart';

import '../../../core/constance/colors.dart';
import '../../../data/models/issues/issue_model.dart';

class CreateIssue extends StatefulWidget {
  const CreateIssue({super.key});

  @override
  State<CreateIssue> createState() => _CreateIssueState();
}

class _CreateIssueState extends State<CreateIssue> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) return;

    final newIssue = Issue(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: desc,
      projectId: "your_project_id",
      authorId: "your_user_id",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Navigator.pop(context, newIssue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        // backgroundColor:ampleOrange,
      title: Text('Create New Issue'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title',),
            style: TextStyle(color:white),
          ),
          TextField(
            controller: _descController,
            style: TextStyle(color:white),
            decoration: InputDecoration(labelText: 'Description',
          ),
            maxLines: 1,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // إلغاء
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text('Create'),
        ),
      ],
    );
  }
}
