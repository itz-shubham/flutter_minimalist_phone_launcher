import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

import '../models/device_applications.dart';
import '../widgets/app_tile.dart';

class AppDrawerScreen extends StatelessWidget {
  const AppDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 64,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search Apps",
                      hintStyle: TextStyle(
                        color: Colors.white70,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                    ),
                    cursorColor: Colors.white,
                    onTapOutside: (_) => primaryFocus?.unfocus(),
                    onChanged: (value) {
                      // print(value);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: DeviceApplications.listenToAppsChanges(),
              builder: (context, _) {
                return FutureBuilder(
                  key: Key(_.data?.packageName ?? ''),
                  future: DeviceApplications.getDeviceInstalledApps(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return AzListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        data: snapshot.data!,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AppTile(
                            appName: snapshot.data![index].application.appName,
                            packageName:
                                snapshot.data![index].application.packageName,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Loading...",
                          style: TextStyle(color: Colors.white30),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
