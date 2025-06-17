import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

Future<String> getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();

  if (GetPlatform.isAndroid) {
    final android = await deviceInfo.androidInfo;
    return '${android.manufacturer} ${android.model}';
  } else if (GetPlatform.isIOS) {
    final ios = await deviceInfo.iosInfo;
    return '${ios.name} ${ios.systemVersion}';
  } else {
    return 'Unknown Device';
  }
}
