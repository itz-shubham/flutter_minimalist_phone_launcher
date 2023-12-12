import 'package:clutter_clear_launcher/widgets/home_screen_clock.dart';
import 'package:flutter/material.dart';

import '../widgets/home_screen_favourite_apps.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: const HomeScreenClock(),
                ),
                Expanded(
                  child: HomeScreenFavouriteApps(
                    alignment: Alignment.bottomLeft,
                    maxLimit: (MediaQuery.of(context).size.height * 0.6) ~/ 56,
                  ),
                )
              ],
            )
          : Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Center(child: HomeScreenClock()),
                ),
                Expanded(
                  flex: 2,
                  child: HomeScreenFavouriteApps(
                    alignment: Alignment.center,
                    maxLimit:
                        (MediaQuery.of(context).size.shortestSide * 0.8) ~/ 56,
                  ),
                ),
              ],
            ),
    );
  }
}
