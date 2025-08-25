import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';
import 'package:pr1/presentation/screen/projects/build_members_list.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/text.dart';

class BuildProjectInfoPage extends StatelessWidget {
  final RetrieveProjectModel retrieveProjectModel;

  const BuildProjectInfoPage(this.retrieveProjectModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: width(context),
      height: height(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.text1(
              retrieveProjectModel.title,
              textColor: white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            buildCreateAtRow(),
            buildCompletedRow(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.text1('project members: ',
                        textColor: white, fontSize: 20),
                    MyGestureDetector.gestureDetector(
                      onTap: () {},
                      child: Container(
                        height: height(context) * 0.05,
                        width: width(context) * 0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(
                          child: MyText.text1('add members'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: height(context) * 0.5,
                    child: BuildMembersList(retrieveProjectModel)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildCompletedRow() {
    return Row(
      children: [
        MyText.text1('completed: ', textColor: white, fontSize: 18),
        MyText.text1(retrieveProjectModel.ended.toString(),
            textColor: white, fontSize: 18),
      ],
    );
  }

  Row buildCreateAtRow() {
    return Row(
      children: [
        MyText.text1('Created at: ', textColor: white, fontSize: 18),
        MyText.text1(
            DateFormat('yyyy - M - dd').format(retrieveProjectModel.createdAt!),
            textColor: white,
            fontSize: 18),
      ],
    );
  }
}
