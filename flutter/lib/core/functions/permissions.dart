import 'package:permission_handler/permission_handler.dart';


Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
  return await permission.status;
}

Future<PermissionStatus> requestPermission(Permission permission) async {
  var status = await permission.status;
  status = await permission.request();
  return status;
}
