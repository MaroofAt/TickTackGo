import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/dependency_cubit/dependency_cubit.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class CreateDependency extends StatefulWidget {
  final Map<String, int> tasks;

  const CreateDependency(this.tasks, {super.key});

  @override
  State<CreateDependency> createState() => _CreateDependencyState();
}

class _CreateDependencyState extends State<CreateDependency> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedConditionTask;
  String? _selectedTargetTask;
  String? _selectedType;
  final Map<String, String> types = {
    'Start To Start': 'start_to_start',
    'Start To Finish': 'start_to_finish',
    'Finish To Start': 'finish_to_start',
    'Finish To Finish': 'finish_to_finish',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: SizedBox(
        height: height(context) * 0.08,
        width: width(context) * 0.5,
        child: MyText.text1('Dependency'),
      ),
      content: SizedBox(
        width: width(context),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: height(context) * 0.1,
                      width: width(context) * 0.28,
                      child: _buildDropdown(
                        label: 'condition',
                        value: _selectedConditionTask,
                        items: widget.tasks.keys.toList(),
                        onChanged: (val) => setState(
                          () {
                            _selectedConditionTask = val ?? '';
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    SizedBox(
                      height: height(context) * 0.1,
                      width: width(context) * 0.28,
                      child: _buildDropdown(
                        label: 'target',
                        value: _selectedTargetTask,
                        items: widget.tasks.keys.toList(),
                        onChanged: (val) => setState(
                          () {
                            _selectedTargetTask = val ?? '';
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context) * 0.1,
                  width: width(context) * 0.8,
                  child: _buildDropdown(
                    label: 'type',
                    value: _selectedType,
                    items: types.keys.toList(),
                    onChanged: (val) => setState(
                      () {
                        _selectedType = val ?? '';
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: height(context) * 0.05,
          width: width(context) * 0.3,
          child: BlocConsumer<DependencyCubit, DependencyState>(
            listener: (context, state) {
              if (state is CreatingDependencyFailedState) {
                NavigationService().popScreen(context);
                MyAlertDialog.showAlertDialog(
                  context,
                  content: state.errorMessage,
                  firstButtonText: okText,
                  firstButtonAction: () {
                    NavigationService().popScreen(context);
                  },
                  secondButtonText: '',
                  secondButtonAction: () {},
                );
              }
              if (state is CreatingDependencySucceededState) {
                NavigationService().popScreen(context, true);
              }
            },
            builder: (context, state) {
              if (state is CreatingDependencyState) {
                return Center(
                  child: LoadingIndicator.circularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  if (_selectedConditionTask != null ||
                      _selectedTargetTask != null ||
                      _selectedType != null) {
                    BlocProvider.of<DependencyCubit>(context).createDependency(
                      widget.tasks[_selectedConditionTask]!,
                      widget.tasks[_selectedTargetTask]!,
                      types[_selectedType]!,
                    );
                  }
                },
                child: MyText.text1('Create'),
              );
            },
          ),
        ),
      ],
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
        initialValue: value,
        style: const TextStyle(color: Colors.white),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
