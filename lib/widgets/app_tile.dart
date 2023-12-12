import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_models/favourite_apps.dart';

class AppTile extends StatefulWidget {
  // final Application application;
  final String appName, packageName;
  const AppTile({super.key, required this.appName, required this.packageName});

  @override
  State<AppTile> createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> {
  bool showingMenu = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceApps.openApp(widget.packageName),
      onLongPressStart: (details) {
        setState(() => showingMenu = true);
        _showAppDetailMenu(
          context,
          details.globalPosition,
          widget.appName,
          widget.packageName,
          () => setState(() => showingMenu = false),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          widget.appName,
          style: TextStyle(
            color: showingMenu ? Colors.white60 : Colors.white,
            fontSize: 24,
          ),
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}

_showAppDetailMenu(BuildContext context, Offset position, String appName,
    String packageName, Function onComplete) async {
  final favouriteAppsBox = Hive.box<FavouriteApps>('favourite_apps_box');
  bool isFavourite = false;
  dynamic favouriteAppKey;
  for (var favouriteApp in favouriteAppsBox.values) {
    if (favouriteApp.packageName == packageName) {
      isFavourite = true;
      favouriteAppKey = favouriteApp.key;
    }
  }
  bool isSystemApp = await DeviceApps.getApp(packageName).then(
    (value) => value?.systemApp ?? false,
  );
  if (context.mounted) {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, 0),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          enabled: false,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white)),
            ),
            child: Text(
              appName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: isFavourite ? 'Remove from favourite' : 'Add to favourite',
          onTap: () => isFavourite
              ? favouriteAppsBox.delete(favouriteAppKey)
              : favouriteAppsBox.add(
                  FavouriteApps(
                    appName: appName,
                    packageName: packageName,
                  ),
                ),
          child:
              Text(isFavourite ? 'Remove from favourite' : 'Add to favourite'),
        ),
        PopupMenuItem(
          child: const Text('App Info'),
          onTap: () => DeviceApps.openAppSettings(packageName),
        ),
        if (!isSystemApp)
          PopupMenuItem(
            value: 'Uninstall',
            child: const Text('Uninstall'),
            onTap: () => DeviceApps.uninstallApp(packageName),
          ),
      ],
    ).whenComplete(() => onComplete());
  }
}
