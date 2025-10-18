import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/presentation/screen/projects/build_projects_list.dart';
import 'package:pr1/presentation/screen/workspace/build_workspaces_list_item.dart';

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
                  NavigationService().push(
                    context,
                    '$workspaceInfoPageRoute/${widget.fetchWorkspacesModel[index].id}',
                    args: {
                      'workspaceCubit': context.read<WorkspaceCubit>(),
                    },
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
