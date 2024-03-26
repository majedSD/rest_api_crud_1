import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/reset_password_controller.dart';
import 'package:rest_api_crud_1/ui/screens/login_screen.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.email, this.pin});
  final String ?email;
  final String ?pin;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
  TextEditingController();
  final TextEditingController _confirmPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ResetPasswordController controller=Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BodyBackground(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 60,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Set Password",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      "Minimum length password 8 character with letters & numbers combination",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _newPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: "New Password",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your New Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: "Confirm Password",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    GetBuilder<ResetPasswordController>(
                      builder: (controller) {
                        return Visibility(
                          visible:controller.setPasswordInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: setNewPassword,
                              child: const Text("Confirm"),
                            ),
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have account?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAll(const LoginScreen());
                          },
                          child: const Text(
                            "Sign in",
                          ),
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
  Future<void> setNewPassword() async {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordTEController.text.length > 7) {
        if (_newPasswordTEController.text ==
            _confirmPasswordTEController.text) {
          bool response = await controller.setNewPassword('${widget.email}','${widget.pin}',_newPasswordTEController.text.trim());
          if (mounted) {
            setState(() {});
          }

          if (response) {
            Get.offAll(const LoginScreen());
          }
          else {
            if (mounted) {
              SnackMessage(context,controller.message);
            }
          }
        } else {
          if(mounted){
            SnackMessage(context, "Confirm password does not matched",apiCallSuccess: false);
          }
        }
      }
    }
  }
}