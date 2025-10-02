import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/data/models/tasks/fetch_tasks_model.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

class AttachmentsDialog extends StatelessWidget {
  final List<AttachmentsDisplayModel> attachmentsDisplayModel;

  const AttachmentsDialog(this.attachmentsDisplayModel, {super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: SizedBox(
        width: width(context) * 0.2,
        height: width(context) * 0.1,
        child: MyText.text1('download attachments', textColor: white),
      ),
      content: SizedBox(
        height: height(context) * 0.15,
        width: width(context) * 0.9,
        child: ListView.builder(
          itemCount: attachmentsDisplayModel.length,
          itemBuilder: (context, index) {
            return MyGestureDetector.gestureDetector(
              onTap: () {
                _launchUrl(attachmentsDisplayModel[index].file);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: MyText.text1('download attachment ${index + 1}',
                      textColor: blue),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
