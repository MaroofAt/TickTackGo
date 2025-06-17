import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/strings.dart';

class MyAlertDialog {
  static void showAlertDialog(
    BuildContext context, {
    required String content,
    required String firstButtonText,
    required void Function() firstButtonAction,
    required String secondButtonText,
    required void Function() secondButtonAction,
    String title = warning,
    IconData icon = Icons.warning,
    Color iconColor = yellow,
    bool contentIsTranslated = false,
    bool reverseColors = false,
    Color? secondButtonColor,
    Color? firstButtonColor,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(
            content,
            style: TextStyle(color: Colors.grey[400]),
          ),
          actions: <Widget>[
            secondButtonText.isNotEmpty
                ? TextButton(
                    onPressed: secondButtonAction,
                    child: Text(
                      secondButtonText,
                      style: TextStyle(
                        color: secondButtonColor ??
                            (reverseColors ? red : Colors.grey[400]),
                      ),
                    ),
                  )
                : Container(),
            TextButton(
              onPressed: firstButtonAction,
              child: Text(
                firstButtonText,
                style: TextStyle(color: reverseColors ? Colors.grey[400] : red),
              ),
            ),
          ],
        );
      },
    );
  }
}
