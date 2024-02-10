import 'package:flutter/material.dart';

import 'screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.tealAccent,
        appBarTheme: const AppBarTheme(color: Colors.cyanAccent),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey,
          focusColor: Colors.pink,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
          ),
        ),
      ),
      home: const ProductList(),
    );
  }
}
