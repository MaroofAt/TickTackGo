import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/presentation/screen/projects/build_project_info_page.dart';
import 'package:pr1/presentation/screen/projects/project_info_app_bar.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class ProjectInfo extends StatefulWidget {
  final int projectId;
  final Color color;

  const ProjectInfo(this.projectId, this.color, {super.key});

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProjectsCubit>(context).retrieveProject(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProjectInfoAppBar.projectInfoAppBar(context, widget.color),
      body: Center(
        child: BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) {
            if (state is ProjectRetrievingSucceededState) {
              return BuildProjectInfoPage(state.retrieveProjectModel);
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
