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
    bool contentIsTranslated = false,
    bool reverseColors = false,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: const Row(
            children: [
              Icon(
                Icons.warning,
                color: yellow,
              ),
              SizedBox(width: 10),
              Text(warning),
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
                        color: reverseColors ? red : Colors.grey[400],
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
