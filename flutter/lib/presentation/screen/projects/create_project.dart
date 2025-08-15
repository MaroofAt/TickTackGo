import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/text_field.dart';

class CreateProjectDialog extends StatefulWidget {
  final int workspaceId;
  final Map<String, int> parentProjects;

  const CreateProjectDialog(this.workspaceId, this.parentProjects, {super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedParent;
  final nameController = TextEditingController();
  Color selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text('Add Project'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField.textField(
                context,
                nameController,
                hint: 'Enter project name',
                textColor: white,
              ),
              const SizedBox(height: 12),
              _buildDropdown(
                label: 'Parent Project',
                value: _selectedParent,
                items: widget.parentProjects.keys.toList(),
                onChanged: (val) => setState(() => _selectedParent = val),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: width(context) * 0.8,
                height: width(context) * 0.1,
                child: buildColorPickerSelector(context),
              ),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: height(context) * 0.05,
          width: width(context) * 0.2,
          child: TextButton(
            onPressed: () => popScreen(context),
            child: MyText.text1('Cancel',textColor: Colors.red),
          ),
        ),
        SizedBox(
          height: height(context) * 0.05,
          width: width(context) * 0.2,
          child: BlocConsumer<ProjectsCubit, ProjectsState>(
            listener: (context, state) {
              if (state is ProjectCreatingFailedState) {
                popScreen(context);
                MyAlertDialog.showAlertDialog(
                  context,
                  content: state.errorMessage,
                  firstButtonText: okText,
                  firstButtonAction: () {
                    popScreen(context);
                  },
                  secondButtonText: '',
                  secondButtonAction: () {},
                );
              }
              if (state is ProjectCreatingSucceededState) {
                popScreen(context, true);
              }
            },
            builder: (context, state) {
              if (state is ProjectCreatingState) {
                return Center(
                  child: LoadingIndicator.circularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ProjectsCubit>(context).createProject(
                    nameController.text,
                    widget.workspaceId,
                    selectedColor,
                    widget.parentProjects[_selectedParent ?? ""],
                  );
                },
                child: MyText.text1('Add'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildColorPickerSelector(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: openColorPicker,
      child: Row(
        spacing: 20,
        children: [
          MyText.text1('pick color', fontSize: 18, textColor: white),
          Container(
            height: width(context) * 0.03,
            width: width(context) * 0.03,
            decoration: BoxDecoration(
              color: selectedColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          focusColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        value: value,
        style: const TextStyle(color: Colors.white),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: SizedBox(
              width: width(context),
              height: height(context) * 0.05,
              child: MyText.text1('Pick a color', textColor: black, textAlign: TextAlign.center)),
          content: SizedBox(
            width: width(context) * 0.9,
            height: height(context) * 0.48,
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: width(context) * 0.2,
              height: height(context) * 0.05,
              child: TextButton(
                child: MyText.text1('Select'),
                onPressed: () {
                  popScreen(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
