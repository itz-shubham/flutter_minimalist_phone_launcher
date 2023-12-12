import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_models/favourite_apps.dart';
import 'app_tile.dart';

class HomeScreenFavouriteApps extends StatelessWidget {
  final Alignment alignment;
  final int maxLimit;
  const HomeScreenFavouriteApps({
    super.key,
    required this.alignment,
    required this.maxLimit,
  });

  @override
  Widget build(BuildContext context) {
    final favouriteAppsBox = Hive.box<FavouriteApps>('favourite_apps_box');
    return ValueListenableBuilder(
      valueListenable: favouriteAppsBox.listenable(),
      builder: (context, box, widget) {
        List<FavouriteApps> apps = [];
        if (box.length > maxLimit) {
          apps = box.values.toList().sublist(box.values.length - maxLimit);
        } else {
          apps = box.values.toList();
        }
        return Align(
          alignment: alignment,
          child: ListView.builder(
            itemCount: apps.length,
            padding: const EdgeInsets.only(left: 32, bottom: 16),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return AppTile(
                appName: apps[index].appName,
                packageName: apps[index].packageName,
              );
            },
          ),
        );
      },
    );
  }
}
