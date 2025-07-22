import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/functions/permissions.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateTaskPage(),
    );
  }
}

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  File? image;

  Future<void> onTap() async {
    Permission galleryPermission = Permission.mediaLibrary;
    PermissionStatus galleryPermissionStatus =
        await checkPermissionStatus(galleryPermission);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: Stack(
          children: [
            Container(
              width: width(context) * 0.35,
              height: width(context) * 0.35,
              decoration: BoxDecoration(
                color: black,
                shape: BoxShape.circle,
                image: image != null
                    ? MyImages.decorationFileImage(image: image!)
                    : MyImages.decorationImage(
                        isAssetImage: true,
                        image: 'assets/images/workspace_images/img.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: MyGestureDetector.gestureDetector(
                onTap: onTap,
                child: Container(
                  width: width(context) * 0.08,
                  height: width(context) * 0.08,
                  decoration: const BoxDecoration(
                    color: white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: MyIcons.icon(Icons.add_photo_alternate),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
