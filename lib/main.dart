import 'package:clutter_clear_launcher/hive_models/favourite_apps.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/appdrawer_screen.dart';
import 'screens/home_screen.dart';
// import 'screens/tool_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FavouriteAppsAdapter());
  await Hive.openBox<FavouriteApps>('favourite_apps_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clutter Clear Launcher',
      theme: ThemeData(
        // colorScheme: ColorScheme(
        //   brightness: brightness,
        //   primary: primary,
        //   onPrimary: onPrimary,
        //   secondary: secondary,
        //   onSecondary: onSecondary,
        //   error: error,
        //   onError: onError,
        //   background: background,
        //   onBackground: onBackground,
        //   surface: surface,
        //   onSurface: onSurface,
        // ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: const Color(0xFF222222),
          // textStyle: const TextStyle(
          //   color: Colors.white,
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelTextStyle: const MaterialStatePropertyAll<TextStyle>(
            TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),

      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      textStyle: const TextStyle(color: Colors.white),
      child: PageView(
        controller: PageController(initialPage: 0),
        children: const [
          // ToolScreen(),
          HomeScreen(),
          AppDrawerScreen(),
        ],
      ),
    );
  }
}
