import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/forget_password_controller.dart';
import 'package:rest_api_crud_1/ui/screens/pin_verification_screen.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  ForgetPasswordController controller=Get.find<ForgetPasswordController>();
  Future<void> getVerifyEmail() async {
    bool response=await controller.getVerifyEmail(_emailTEController.text.trim());
    if (response) {
      if(mounted){
        SnackMessage(context, controller.message);
      }
      Get.to( PinVerificationScreen(
        email:_emailTEController.text.trim(),
      ),);
    }
    else{
      if(mounted) {
        SnackMessage(context, controller.message, apiCallSuccess: false);
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      "Your Email Address",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'A 6 digit verification pin will send to your email address',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator:emailValidator,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: GetBuilder<ForgetPasswordController>(
                        builder: (controller) {
                          return Visibility(
                            visible:controller.loginProgress==false,
                            replacement:const Center(child: CircularProgressIndicator(),),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  getVerifyEmail();
                                }
                              },
                              child: const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          );
                        }
                      ),),
                    const SizedBox(
                      height: 30,
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
                           Get.back();
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
  @override
  void dispose() {
    super.dispose();
    _emailTEController.clear();
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
}