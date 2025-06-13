import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  File? image;
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    image = File(pickedFile.path);
  }
  return image;
}
