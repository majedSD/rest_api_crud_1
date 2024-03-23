import 'package:flutter/material.dart';

import 'ui/screens/splash_screen.dart';

class FlutterTaskManagerApp extends StatelessWidget {
  const FlutterTaskManagerApp({super.key});
  static final GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:navigatorKey,
      theme: ThemeData(
       // brightness: Brightness.dark,
        textTheme:const TextTheme(
          titleLarge:TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600
          ),
        ),
        primaryColor: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border:OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent)
            ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black54,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style:TextButton.styleFrom(
            foregroundColor: Colors.purple,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
          ),
        ),
        hintColor: Colors.grey,
        floatingActionButtonTheme:const FloatingActionButtonThemeData(
          backgroundColor: Colors.cyanAccent,
        )
      ),
      home: const SplashScreen(),
    );
  }
}
