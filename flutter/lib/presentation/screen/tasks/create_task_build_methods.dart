import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pr1/business_logic/task_cubit/task_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/circle.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/text_field.dart';

Widget buildDropdown(
  BuildContext context, {
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

Column buildStartEndDate(
  BuildContext context, {
  required String label,
  required Function(BuildContext) onTap,
  required DateTime selectedDate,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyText.text1(
        label,
        textColor: white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      const SizedBox(height: 8),
      InkWell(
        onTap: () => onTap(context),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE, d MMM y').format(selectedDate),
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
    ],
  );
}

Column buildPriorityWrap(BuildContext context, String label, List<String> list,
    String selectedValue, Function(String text) onTap) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: width(context),
        child: MyText.text1('$label :',
            textColor: white, fontSize: 18, textAlign: TextAlign.start),
      ),
      Wrap(
        spacing: 10,
        children: list.map(
          (item) {
            return MyGestureDetector.gestureDetector(
              onTap: () {
                onTap(item);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: item,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      onTap(value!);
                    },
                    activeColor: white,
                  ),
                  MyText.text1(
                    item,
                    textColor: white,
                    fontSize: 14,
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    ],
  );
}

Expanded _buildStartEndTimeSelector(
  BuildContext context, {
  required String label,
  required Function(BuildContext) onTap,
  required TimeOfDay timeFormat,
}) {
  return Expanded(
    child: InkWell(
      onTap: () {
        onTap(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.text1(
            label,
            textColor: white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.text1(
                  timeFormat.format(context),
                  textColor: white,
                  fontSize: 16,
                ),
                const Icon(
                  Icons.access_time,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Stack buildSelectImage(BuildContext context) {
  return Stack(
    children: [
      BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return BlocProvider.of<TaskCubit>(context).image == null
              ? MyCircle.circle(
                  width(context) * 0.35,
                  color: white,
                )
              : MyCircle.circleWithFileImage(width(context) * 0.35,
                  file: BlocProvider.of<TaskCubit>(context).image!);
        },
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: BlocListener<TaskCubit, TaskState>(
          listener: (context, state) {},
          child: MyGestureDetector.gestureDetector(
            onTap: BlocProvider.of<TaskCubit>(context).getTaskImage,
            child: Container(
              width: width(context) * 0.08,
              height: width(context) * 0.08,
              decoration: const BoxDecoration(
                color: white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: MyIcons.icon(Icons.add_photo_alternate),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Column buildTextFieldsColumn(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController descriptionController) {
  return Column(
    spacing: 20,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.text1(
            'Title *',
            textColor: white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          const SizedBox(height: 8),
          MyTextField.textField(
            context,
            titleController,
            textColor: white,
            hint: 'task title',
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.text1(
            'Description',
            textColor: white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          const SizedBox(height: 8),
          MyTextField.textField(
            context,
            descriptionController,
            textColor: white,
            maxLines: 3,
            hint: 'task description',
          ),
        ],
      ),
    ],
  );
}

Positioned buildBottomContainer(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController descriptionController,
    int workspaceId,
    int projectId) {
  return Positioned(
    bottom: 0,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: height(context) * 0.1,
      width: width(context),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
                color: lightGrey.withAlpha(50), spreadRadius: 5, blurRadius: 5)
          ]),
      child: SizedBox(
        width: width(context) * 0.9,
        height: height(context) * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<TaskCubit, TaskState>(
              listener: (context, state) {
                if (state is TaskCreatingSucceededState) {
                  popScreen(context, true);
                }
                if (state is TaskCreatingFailedState) {
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
              },
              builder: (context, state) {
                if (state is TaskCreatingState) {
                  return MyButtons.primaryButton(
                    () {},
                    Theme.of(context).primaryColor,
                    child: Center(
                      child: LoadingIndicator.circularProgressIndicator(),
                    ),
                  );
                }
                return SizedBox(
                  height: height(context) * 0.05,
                  child: MyButtons.primaryButton(
                    () {
                      BlocProvider.of<TaskCubit>(context).createTask(
                        titleController.text,
                        descriptionController.text,
                        workspaceId,
                        projectId,
                      );
                    },
                    Theme.of(context).primaryColor,
                    child: Center(
                      child: MyText.text1(
                        'Create Task',
                        textColor: white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: height(context) * 0.05,
              width: width(context) * 0.3,
              child: MyButtons.primaryButton(
                () {
                  popScreen(context);
                },
                darkGrey,
                child: Center(
                  child: MyText.text1('Cancel', textColor: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Row buildLockedSwitch(BuildContext context) {
  return Row(
    children: [
      MyText.text1('locked: ', textColor: white, fontSize: 22),
      Switch(
        value: BlocProvider.of<TaskCubit>(context).locked,
        onChanged: (value) {
          BlocProvider.of<TaskCubit>(context).changeTaskLocked();
        },
      ),
    ],
  );
}
