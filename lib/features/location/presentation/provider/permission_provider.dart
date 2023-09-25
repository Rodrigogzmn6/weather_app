import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider = FutureProvider<bool>((ref) async {
  final PermissionStatus permissionStatus = await Permission.location.request();
  return permissionStatus.isGranted ? true : throw ('Permissions are denied');
});
