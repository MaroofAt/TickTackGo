import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildListItem extends StatelessWidget {
  Function() onWorkspaceTap;
  Function() onArrowTap;
  String workspaceName;

  BuildListItem(this.workspaceName,
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
                    image: MyImages.decorationImage(
                        isAssetImage: true,
                        image: 'assets/images/workspace_images/img.png'),
                  ),
                ),
                MyText.text1(workspaceName, fontSize: 18, textColor: white),
              ],
            ),
            MyButtons.primaryButton(
              onArrowTap,
              Theme.of(context).scaffoldBackgroundColor,
              child: MyIcons.icon(
                Icons.keyboard_arrow_down_outlined,
                color: lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
