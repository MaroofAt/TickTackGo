import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/presentation/screen/projects/build_project_info_page.dart';
import 'package:pr1/presentation/screen/projects/project_info_app_bar.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({super.key});

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  int? projectId;
  Color? color;
  int? workspaceId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    projectId = args['projectId'];
    color = args['color'];
    workspaceId = args['workspaceId'];

    BlocProvider.of<ProjectsCubit>(context).retrieveProject(projectId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProjectInfoAppBar.projectInfoAppBar(context, color!),
      body: Center(
        child: BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) {
            if (state is ProjectRetrievingSucceededState) {
              return BuildProjectInfoPage(
                state.retrieveProjectModel,
                workspaceId!,
                projectId: projectId!,
              );
            }
            return Center(
              child: LoadingIndicator.circularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
