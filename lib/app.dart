import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/add_new_task_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/cancelled_task_screen_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/completed_task_screen_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/edit_profile_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/forget_password_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/new_task_screen_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/login_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/progress_task_screen_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/reset_password_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/signup_screen_controller.dart';

import 'ui/screens/splash_screen.dart';

class FlutterTaskManagerApp extends StatelessWidget {
  const FlutterTaskManagerApp({super.key});
  static final GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      initialBinding:ControllerBinder(),
    );
  }
}
class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(NewTaskScreenController());
    Get.put(AddNewTaskController());
    Get.put(ProgressTaskScreenController());
    Get.put(CompletedTaskScreenController());
    Get.put(CancelledTaskScreenController());
    Get.put(AuthController());
    Get.put(SignUpScreenController());
    Get.put(ResetPasswordController());
    Get.put(ForgetPasswordController());
    Get.put(EditProfileController());
  }

}