import 'dart:io';

import 'package:dio/dio.dart';
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

Future<bool> checkImageExists(String imageUrl) async {
  try {
    final response = await Dio().head(imageUrl);
    return response.statusCode == 200;
  } on DioException catch (e) {
    // Handle Dio-specific errors
    if (e.response != null) {
      // The request was made and the server responded with a status code
      return false;
    } else {
      // Something happened in setting up or sending the request
      return false;
    }
  } catch (e) {
    // Handle any other errors
    return false;
  }
}
