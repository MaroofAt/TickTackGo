import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/workspace/get_workspaces_model.dart';
import 'package:pr1/presentation/screen/projects/build_projects_list.dart';
import 'package:pr1/presentation/screen/workspace/build_workspaces_list_item.dart';
import 'package:pr1/presentation/screen/workspace/workspace_info_page.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildWorkspacesList extends StatefulWidget {
  final List<FetchWorkspacesModel> fetchWorkspacesModel;

  BuildWorkspacesList(this.fetchWorkspacesModel, {super.key});

  @override
  State<BuildWorkspacesList> createState() => _BuildWorkspacesListState();
}

class _BuildWorkspacesListState extends State<BuildWorkspacesList> {
  late int _selectedIndex = widget.fetchWorkspacesModel.length;
  int? _openedWorkspace;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.fetchWorkspacesModel.length + 1,
      itemBuilder: (context, index) {
        if (_selectedIndex == index) {
          return BlocBuilder<ProjectsCubit, ProjectsState>(
            builder: (context, state) {
              if (state is ProjectsFetchingSucceededState) {
                if (state.projects.isEmpty) {
                  return MyText.text1('No projects for this workspace',
                      fontSize: 18, textColor: white);
                }
                return BuildProjectsList(state.projects);
              } else if (state is ProjectsFetchingState) {
                return Center(
                  child: LoadingIndicator.circularProgressIndicator(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                );
              }
              return Container();
            },
          );
        }
        return BuildListItem(
          _selectedIndex < index
              ? widget.fetchWorkspacesModel[index - 1]
              : widget.fetchWorkspacesModel[index],
          openedWorkspace: _openedWorkspace,
          onWorkspaceTap: () {
            pushScreen(
              context,
              BlocProvider(
                create: (context) => WorkspaceCubit(),
                child: WorkspaceInfoPage(widget.fetchWorkspacesModel[index].id),
              ),
            );
          },
          onArrowTap: () {
            if (_selectedIndex - 1 == index && _openedWorkspace == null) {
              _selectedIndex = widget.fetchWorkspacesModel.length;
              setState(() {});
            } else {
              _selectedIndex = index + 1;
              _openedWorkspace = widget.fetchWorkspacesModel[index].id;
              if(_selectedIndex < index) {
                BlocProvider.of<ProjectsCubit>(context)
                    .fetchProjects(widget.fetchWorkspacesModel[index].id);
              }else {
                BlocProvider.of<ProjectsCubit>(context)
                    .fetchProjects(widget.fetchWorkspacesModel[index].id);
              }
              _openedWorkspace = null;
              setState(() {});
            }
          },
        );
      },
    );
  }
}
