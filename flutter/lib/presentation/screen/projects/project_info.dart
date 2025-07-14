import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/presentation/screen/projects/build_project_info_page.dart';
import 'package:pr1/presentation/widgets/app_bar.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class ProjectInfo extends StatelessWidget {
  final String title;
  final int id;

  const ProjectInfo(this.title, this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.appBar(
        context,
        title: MyText.text1(title),
      ),
      body: BlocBuilder(
        builder: (context, state) {
          if (state is ProjectRetrievingSucceededState) {
            return const BuildProjectInfoPage();
          }
          return Center(
            child: LoadingIndicator.circularProgressIndicator(),
          );
        },
      ),
    );
  }
}
