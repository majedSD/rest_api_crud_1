
import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/data/models/user_model.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';
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
  bool _inProgress=false;
  Future<void>postLoginRequest()async{
    if(_formKey.currentState!.validate()){
      _inProgress=true;
      setState(() {});
      NetworkResponse response=await NetworkCaller().postRequest(Urls.login,body: {
        "email":_emailTEController.text.trim(),
        "password":_passwordTEController.text.trim(),
      },isLogin:true);
      if(response.statusCode==200){
        setState(() {});
        AuthController.setUserInformation(response.jsonResponse['token'],UserModel.fromJson(response.jsonResponse['data']));
        if(mounted) {
          SnackMessage(
              context, "Login Successfully completed");
        }
        if(mounted) {
          Navigator.push(context, MaterialPageRoute(
              builder: (
                  context) => const MainBottomNavScreen()));
        }
      }
      else{
        if(mounted) {
          SnackMessage(context, "Login failed! try again",apiCallSuccess: false);
        }
      }
      _inProgress=false;
      setState(() {});
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
                            setState(() {
                              _obscureText = !_obscureText;
                            });
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
                        child: Visibility(
                          visible:_inProgress==false,
                          replacement:const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed:postLoginRequest,
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        )),
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen()));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
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
