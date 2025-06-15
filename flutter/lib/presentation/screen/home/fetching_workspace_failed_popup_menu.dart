import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class FetchingWorkspaceFailedPopupMenu extends StatelessWidget {
  String errorMessage;

  FetchingWorkspaceFailedPopupMenu(this.errorMessage,{super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: MyIcons.icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: MyText.text1(errorMessage),
          ),
          PopupMenuItem(
            child: MyGestureDetector.gestureDetector(
                onTap: () {
                  BlocProvider.of<WorkspaceCubit>(context).fetchWorkspaces(1);
                  popScreen(context);
                },
                child: MyIcons.icon(Icons.refresh,color: white)),
          ),
        ];
      },
    );
  }
}
