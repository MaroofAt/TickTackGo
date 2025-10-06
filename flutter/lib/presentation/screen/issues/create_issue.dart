import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/issues/issues_cubit.dart';
import 'package:pr1/presentation/widgets/text.dart';

import '../../../core/constance/colors.dart';

class CreateIssue extends StatefulWidget {
  final int projectId;
  const CreateIssue({super.key,required this.projectId});

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
      title: MyText.text1('Create New Issue'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title',),
            style: const TextStyle(color: white),
          ),
          TextField(
            controller: _descController,
            style: const TextStyle(color: white),
            decoration: const InputDecoration(labelText: 'Description',
            ),
            maxLines: 1,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
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
                  projectId: widget.projectId,
                );

                Navigator.pop(context, true);
              },
              child: const Text('Create'),
            );

          },
        ),
      ],
    )
    ;
  }
}
