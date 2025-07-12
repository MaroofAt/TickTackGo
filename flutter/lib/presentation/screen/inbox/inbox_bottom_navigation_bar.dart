import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/inbox_cubit/inbox_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/data/models/inbox/inbox_tasks_model.dart';
import 'package:pr1/presentation/screen/inbox/inbox_bottom_sheet.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class InboxBottomNavigationBar extends StatelessWidget {
  final String label;
  final Icon? icon;
  final bool withDeleteButton;
  final InboxTasksModel? inboxTasksModel;

  const InboxBottomNavigationBar(this.label, this.withDeleteButton,
      {this.icon, this.inboxTasksModel, super.key});

  @override
  Widget build(BuildContext context) {
    return MyButtons.primaryButton(
      () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Full height
          backgroundColor: Colors.transparent, // For rounded corners
          builder: (context) => BlocProvider(
            create: (context) => InboxCubit(),
            child: InboxBottomSheet(
              withDeleteButton,
              inboxTasksModel: inboxTasksModel,
            ),
          ),
        );
      },
      Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          MyText.text1(label, textColor: white, fontSize: 20),
        ],
      ),
    );
  }
}
