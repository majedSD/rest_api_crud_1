
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/login_controller.dart';
import 'package:rest_api_crud_1/ui/screens/forget_password_screen.dart';
import 'package:rest_api_crud_1/ui/screens/main_bottom_nav_screen.dart';
import 'package:rest_api_crud_1/ui/screens/signup_screen.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController=Get.find<LoginController>();

  Future<void>postLoginRequest()async{
    if(_formKey.currentState!.validate()){
    final bool response=await _loginController.postLoginRequest(
        _emailTEController.text.trim(),
        _passwordTEController.text.trim()
    );
      if(response){
        if(mounted) {
          SnackMessage(context, _loginController.message);
        }
       Get.to(const MainBottomNavScreen());
      }
      else {
        if (mounted) {
          SnackMessage(context, _loginController.message, apiCallSuccess: false);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    Text(
                      "Get Started with",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator: Validator,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: _obscureText,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: InkWell(
                          onTap: () {
                              _obscureText = !_obscureText;
                            setState(() {});
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: Validator,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: GetBuilder<LoginController>(
                          builder: (loginController) {
                            return Visibility(
                              visible:loginController.loginProgress==false,
                              replacement:const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: ElevatedButton(
                                onPressed:postLoginRequest,
                                child: const Icon(Icons.arrow_circle_right_outlined),
                              ),
                            );
                          }
                        )),
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to( const ForgetPasswordScreen());
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                           Get.to(const SignupScreen());
                          },
                          child: const Text('Sign up'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? Validator(String? value) {
    if (value!.isEmpty) {
      return "Enter the valid value";
    }
    return null;
  }
  @override
  void dispose(){
    super.dispose();
  _emailTEController.clear();
    _passwordTEController.clear();
  }
}
