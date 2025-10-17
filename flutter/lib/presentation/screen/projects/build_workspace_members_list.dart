import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/business_logic/workspace_cubit/workspace_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';
import 'package:pr1/data/models/workspace/get_workspace_model.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildWorkspaceMembersList extends StatefulWidget {
  const BuildWorkspaceMembersList({super.key});

  @override
  State<BuildWorkspaceMembersList> createState() =>
      _BuildWorkspaceMembersListState();
}

class _BuildWorkspaceMembersListState extends State<BuildWorkspaceMembersList> {
  int? workspaceId;
  RetrieveProjectModel? retrieveProjectModel;
  ProjectsCubit? projectsCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    workspaceId = args['workspaceId'];
    retrieveProjectModel = args['retrieveProjectModel'];
    projectsCubit = args['projectsCubit'];
    _getWorkspace();
  }

  _getWorkspace() {
    BlocProvider.of<WorkspaceCubit>(context)
        .retrieveWorkspace(workspaceId!);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && result != null) {
          projectsCubit!.retrieveProject(retrieveProjectModel!.id);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: width(context),
                  child: MyText.text1(
                    'add members to ${retrieveProjectModel!.title}',
                    textColor: white,
                    fontSize: 20,
                  ),
                ),
                BlocBuilder<WorkspaceCubit, WorkspaceState>(
                  builder: (context, state) {
                    if (state is WorkspaceRetrievingSucceededState) {
                      RetrieveWorkspaceModel retrieveWorkspaceModel =
                          state.retrieveWorkspace;
                      if (retrieveProjectModel!.members.length == 1) {
                        return Center(
                          child: MyText.text1(
                            '\n\nAdd some member to this workspace so you can add them to this project',
                            textColor: white,
                            fontSize: 20,
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: retrieveWorkspaceModel.members.length,
                          itemBuilder: (context, index) {
                            final isAlreadyMember =
                                retrieveProjectModel!.members.any((m) =>
                                    m.member.id ==
                                    retrieveWorkspaceModel
                                        .members[index].member.id);
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              height: height(context) * 0.1,
                              width: width(context) * 0.9,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // Container(
                                      //   height: height(context) * 0.07,
                                      //   width: height(context) * 0.07,
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     image: MyImages.decorationImage(
                                      //         isAssetImage: false,
                                      //         image: retrieveWorkspaceModel
                                      //             .members[index].member.image),
                                      //   ),
                                      // ),
                                      MyText.text1(
                                          retrieveWorkspaceModel
                                              .members[index].member.username,
                                          textColor: white,
                                          fontSize: 22),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.04,
                                    width: width(context) * 0.25,
                                    child: MyButtons.primaryButton(
                                      () {
                                        BlocProvider.of<ProjectsCubit>(context)
                                            .addMemberToProject(
                                                retrieveProjectModel!.id,
                                                retrieveWorkspaceModel
                                                    .members[index].member.id);
                                      },
                                      isAlreadyMember
                                          ? lightGrey
                                          : Theme.of(context).primaryColor,
                                      child: Center(
                                        child: BlocConsumer<ProjectsCubit,
                                            ProjectsState>(
                                          listener: (context, state) {
                                            if (state
                                                is AddingMemberToProjectSucceededState) {
                                              NavigationService().popScreen(context, true);
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state
                                                is AddingMemberToProjectState) {
                                              return LoadingIndicator
                                                  .circularProgressIndicator();
                                            }
                                            return MyText.text1('Add',
                                                textColor: white, fontSize: 18);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: LoadingIndicator.circularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
