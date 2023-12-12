import 'package:azlistview/azlistview.dart';
import 'package:device_apps/device_apps.dart';

class DeviceApplications extends ISuspensionBean {
  final Application application;
  final String tag;

  DeviceApplications(this.application, this.tag);

  @override
  String getSuspensionTag() => tag;

  static Future<List<DeviceApplications>> getDeviceInstalledApps() async {
    var apps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    apps.sort((a, b) => a.appName.compareTo(b.appName));
    return apps
        .map((e) => DeviceApplications(e, e.appName[0].toUpperCase()))
        .toList();
  }

  static Stream<ApplicationEvent> listenToAppsChanges() =>
      DeviceApps.listenToAppsChanges();
}
