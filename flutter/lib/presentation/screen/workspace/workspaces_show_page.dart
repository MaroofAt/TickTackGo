import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/workspace/build_workspaces_list.dart';
import 'package:pr1/presentation/screen/workspace/build_workspaces_list_item.dart';
import 'package:pr1/presentation/screen/workspace/show_workspaces_app_bar.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_page.dart';
import 'package:pr1/presentation/widgets/alert_dialog.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WorkspacesShowPage extends StatefulWidget {
  const WorkspacesShowPage({super.key});

  @override
  State<WorkspacesShowPage> createState() => _WorkspacesShowPageState();
}

class _WorkspacesShowPageState extends State<WorkspacesShowPage> {
  @override
  void initState() {
    super.initState();
    getWorkspaces();
  }

  getWorkspaces() {
    BlocProvider.of<WorkspaceCubit>(context).fetchWorkspaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShowWorkspacesAppBar.workspacesAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushNamed(context, workspaceCreatePageRoute);
        },
        child: MyIcons.icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        height: height(context),
        width: width(context),
        child: BlocConsumer<WorkspaceCubit, WorkspaceState>(
          listener: (context, state) {
            if (state is WorkspacesFetchingFailedState) {
              MyAlertDialog.showAlertDialog(
                context,
                content: state.errorMessage,
                firstButtonText: okText,
                firstButtonAction: () {
                  popScreen(context);
                  popScreen(context);
                },
                secondButtonText: '',
                secondButtonAction: () {},
              );
            }
          },
          builder: (context, state) {
            if (state is WorkspacesFetchingSucceededState) {
              return BlocProvider(
                create: (context) => ProjectsCubit(),
                child: BuildWorkspacesList(state.fetchWorkspacesModel),
              );
            } else {
              return Center(
                child: LoadingIndicator.circularProgressIndicator(
                  color: Theme
                      .of(context)
                      .secondaryHeaderColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
