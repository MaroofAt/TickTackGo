import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/presentation/screen/projects/build_projects_list.dart';
import 'package:pr1/presentation/screen/workspace/build_workspaces_list_item.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_page.dart';

class BuildWorkspacesList extends StatefulWidget {
  final List<FetchWorkspacesModel> fetchWorkspacesModel;

  const BuildWorkspacesList(this.fetchWorkspacesModel, {super.key});

  @override
  State<BuildWorkspacesList> createState() => _BuildWorkspacesListState();
}

class _BuildWorkspacesListState extends State<BuildWorkspacesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.fetchWorkspacesModel.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Column(
            children: [
              BuildListItem(
                widget.fetchWorkspacesModel[index],
                onWorkspaceTap: () {
                  pushScreen(
                    context,
                    BlocProvider(
                      create: (context) => WorkspaceCubit(),
                      child: PopScope(
                        onPopInvokedWithResult: (didPop, result) {
                          if (didPop && result != null) {
                            BlocProvider.of<WorkspaceCubit>(context)
                                .fetchWorkspaces();
                          }
                        },
                        child: WorkspaceInfoPage(
                          widget.fetchWorkspacesModel[index].id,
                        ),
                      ),
                    ),
                  );
                },
                onArrowTap: () {
                  BlocProvider.of<ProjectsCubit>(context)
                      .onArrowTap(widget.fetchWorkspacesModel[index].id);
                  setState(() {});
                },
              ),
              BlocProvider.of<ProjectsCubit>(context).selectedWorkspaceId !=
                          null &&
                      BlocProvider.of<ProjectsCubit>(context)
                              .selectedWorkspaceId ==
                          widget.fetchWorkspacesModel[index].id
                  ? BuildProjectsList(
                      widget.fetchWorkspacesModel[index].projects,
                      widget.fetchWorkspacesModel[index].id)
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
