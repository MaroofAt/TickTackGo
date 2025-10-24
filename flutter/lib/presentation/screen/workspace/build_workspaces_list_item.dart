import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/projects_cubit/projects_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import 'package:pr1/data/models/workspace/fetch_workspaces_model.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildListItem extends StatelessWidget {
  Function() onWorkspaceTap;
  Function() onArrowTap;
  FetchWorkspacesModel fetchWorkspacesModel;

  BuildListItem(this.fetchWorkspacesModel,
      {required this.onWorkspaceTap, required this.onArrowTap, super.key});

  @override
  Widget build(BuildContext context) {
    return MyGestureDetector.gestureDetector(
      onTap: onWorkspaceTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: height(context) * 0.1,
        decoration: BoxDecoration(
          color: transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: height(context) * 0.1,
                  width: height(context) * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: fetchWorkspacesModel.image == null
                        ? MyImages.decorationImage(
                            isAssetImage: true,
                            image: 'assets/images/workspace_images/img.png')
                        : MyImages.decorationImage(
                            isAssetImage: false,
                            image: fetchWorkspacesModel.image,
                          ),
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.4,
                  height: width(context) * 0.1,
                  child: MyText.text1(fetchWorkspacesModel.title,
                      fontSize: 18, textColor: white, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Row(
              children: [
                MyGestureDetector.gestureDetector(
                  onTap: () {
                    NavigationService().push(context,
                        '$pointsStatisticsRoute/${fetchWorkspacesModel.id}/${fetchWorkspacesModel.title}');
                  },
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: MyIcons.icon(Icons.star, color: yellow),
                  ),
                ),
                MyButtons.primaryButton(
                  onArrowTap,
                  Theme.of(context).scaffoldBackgroundColor,
                  child: BlocBuilder<ProjectsCubit, ProjectsState>(
                    builder: (context, state) {
                      return MyIcons.icon(
                        !BlocProvider.of<ProjectsCubit>(context)
                                .checkForIconType(fetchWorkspacesModel.id)
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_down_outlined,
                        color: lightGrey,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
