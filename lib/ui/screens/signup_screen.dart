import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';
import 'package:rest_api_crud_1/ui/screens/login_screen.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;
  bool apiCallSuccess = true;
  bool _obscureText = true;

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
                    const SizedBox(height: 100),
                    Text(
                      "Join with us",
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
                        validator: emailValidator),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "First name",
                      ),
                      validator: Validator,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Last name",
                      ),
                      validator: Validator,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Mobile",
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
                        suffixIcon: PasswordVisibility(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Visibility(
                          visible: _inProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              await _signUp(context);
                            },
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Sign In'),
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

  Future<void> _signUp(BuildContext context) async {
      if (_formKey.currentState!.validate()) {
      _inProgress = true;
      setState(() {});
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.registration, body: {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
        "password": _passwordTEController.text,
        "photo": "",
      });
      _inProgress = false;
      setState(() {});
      if (response.statusCode == 200) {
        if (mounted) {
          SnackMessage(context, "Successfully SignUp go to login");
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=>const LoginScreen()), (route) => false);
        }
        _emailTEController.clear();
        _firstNameTEController.clear();
        _lastNameTEController.clear();
        _mobileTEController.clear();
        _passwordTEController.clear();
      } else {
        if (mounted) {
          SnackMessage(context, "Log in failed! please try again",
              apiCallSuccess: false);
        }
      }
    }
  }

  InkWell PasswordVisibility() {
    return InkWell(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Icon(
        _obscureText ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
    );
  }
  String? Validator(String? value) {
    if (value!.trim().isEmpty) {
      return "Enter a valid value";
    }
  }

  String? emailValidator(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }
}
