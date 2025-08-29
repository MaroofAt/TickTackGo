import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/data/models/issues/issue_create.dart';
import 'package:pr1/data/models/issues/list_issues_model.dart';

import '../../../core/constance/colors.dart';
import '../../../data/models/issues/issue_model.dart';

class CreateIssue extends StatefulWidget {
  final project_Id;
  const CreateIssue({super.key, this.project_Id});

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

//   void _submit() {
//     final title = _titleController.text.trim();
//     final desc = _descController.text.trim();
//
//     if (title.isEmpty || desc.isEmpty) return;
//
//     final newIssue = IssueModel(
//       title: title,
//       description: desc,
//       projectId: 3,
//     );
// context.read<IssuesCubit>().createIssue(title: title, description: desc, projectId: 1);
//     Navigator.pop(context, newIssue);
//   }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text('Create New Issue'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title',),
            style: TextStyle(color: white),
          ),
          TextField(
            controller: _descController,
            style: TextStyle(color: white),
            decoration: InputDecoration(labelText: 'Description',
            ),
            maxLines: 1,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        BlocBuilder<IssuesCubit, IssuesState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () async {
                final title = _titleController.text.trim();
                final desc = _descController.text.trim();

                if (title.isEmpty || desc.isEmpty) return;

                await context.read<IssuesCubit>().createIssue(
                  title: title,
                  description: desc,
                  projectId: widget.project_Id,
                );

                Navigator.pop(context, true);
              },
              child: Text('Create'),
            );

          },
        ),
      ],
    )
    ;
  }
}
