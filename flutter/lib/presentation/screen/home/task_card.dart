import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: height(context) * 0.16,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(left: BorderSide(width: 12, color: sleekCyan)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: width(context) * 0.08,
                width: width(context) * 0.3,
                decoration: BoxDecoration(
                    color: sleekCyan, borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: MyText.text1('status',
                      textColor: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
              MyText.text1('task title', textColor: white, fontSize: 18),
              Row(
                spacing: 10,
                children: [
                  MyIcons.icon(Icons.access_time, color: Colors.grey[400]),
                  MyText.text1('20/12/2025', textColor: Colors.grey[400])
                ],
              )
            ],
          ),
          Column(
            children: [
              MyGestureDetector.gestureDetector(
                onTap: () {
                  //TODO task info page
                },
                child: MyIcons.icon(
                  Icons.more_vert,
                  color: Colors.grey[400],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
