import 'package:permission_handler/permission_handler.dart';


Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
  return await permission.status;
}

Future<PermissionStatus> requestPermission(Permission permission) async {
  final status = await permission.status;

  if (status.isDenied || status.isRestricted || status.isLimited) {
    final result = await permission.request();
    return result;
  }

  return status;
}
