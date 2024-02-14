import 'package:flutter/material.dart';

import 'ui/screens/splash_screen.dart';

class FlutterTaskManagerApp extends StatelessWidget {
  const FlutterTaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

      ),
      home:SplashScreen(),
    );
  }
}
