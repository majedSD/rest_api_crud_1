import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rest_api_crud_1/ui/controllers/forget_password_controller.dart';
import 'package:rest_api_crud_1/ui/screens/reset_password_screen.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, this.email});
  final String?email;
  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinCodeTFTEController=TextEditingController();
  ForgetPasswordController controller=Get.find<ForgetPasswordController>();
  Future<void> getVerifyOTP() async {
    bool response=await controller.getVerifyOTP('${widget.email}',_pinCodeTFTEController.text.trim());
    if (response) {
      if (mounted) {
        SnackMessage(context,controller.Message);
        Get.to(ResetPasswordScreen(
            email: widget.email,
            pin: _pinCodeTFTEController.text
        ));
      }
      else {
        if (mounted) {
          SnackMessage(
              context,controller.Message, apiCallSuccess: false);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    "Pin Verification",
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
                  PinCodeTextField(
                    controller: _pinCodeTFTEController,
                    textInputAction: TextInputAction.next,
                    length: 6,
                    obscureText: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      fieldOuterPadding: const EdgeInsets.all(5),
                      inactiveFillColor: Colors.cyanAccent,
                    ),
                    onChanged: (value) {
                    },
                    backgroundColor: Colors.white,
                    appContext: (context),
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
                            visible:controller.LoginProgress==false,
                            replacement:const Center(child: CircularProgressIndicator(),),
                            child: ElevatedButton(
                              onPressed: getVerifyOTP,
                              child: const Text("Verify"),
                            ),
                          );
                        }
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
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
    );
  }
}