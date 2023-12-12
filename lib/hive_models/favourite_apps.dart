import 'package:hive/hive.dart';

part 'favourite_apps.g.dart';

@HiveType(typeId: 0)
class FavouriteApps extends HiveObject {
  @HiveField(0)
  final String appName;

  @HiveField(1)
  final String packageName;

  FavouriteApps({required this.appName, required this.packageName});
}
