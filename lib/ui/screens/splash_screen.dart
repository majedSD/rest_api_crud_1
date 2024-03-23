import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';
import 'package:rest_api_crud_1/ui/screens/login_screen.dart';
import 'package:rest_api_crud_1/ui/screens/main_bottom_nav_screen.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  Future<void> goToLogin() async {
   //final bool loginUserOrNot=await AuthController.checkAuthState();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  const LoginScreen()),
          (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 120,
          ),
        ),
      ),
    );
  }
}
