
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_api_crud_1/ui/controllers/edit_profile_controller.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/profile_summary_card.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

import '../controllers/auth_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  AuthController controller=Get.find<AuthController>();
  // ignore: non_constant_identifier_names
  EditProfileController Controller=Get.find<EditProfileController>();
  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = controller.user?.email ?? '';
    _firstNameTEController.text = controller.user?.firstName ?? '';
    _lastNameTEController.text = controller.user?.lastName ?? '';
    _mobileTEController.text = controller.user?.mobile ?? '';
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const ProfileSummaryCard(
                enableOnTap: false,
              ),
              Expanded(
                child: BodyBackground(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Update Profile',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          photoPickerField(),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _emailTEController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your valid email';
                              } else if (!_isValidEmail(value!)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _firstNameTEController,
                            decoration:
                            const InputDecoration(hintText: 'First name'),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your first name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _lastNameTEController,
                            decoration:
                            const InputDecoration(hintText: 'Last name'),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your last name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _mobileTEController,
                            decoration: const InputDecoration(hintText: 'Mobile'),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your mobile';
                              }
                              if (value?.trim().length!=11) {
                                return 'Enter your valid mobile no';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _passwordTEController,
                            decoration:
                            const InputDecoration(hintText: 'Password (optional)'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<EditProfileController>(
                              builder: (controller) {
                                return Visibility(
                                  visible:controller.updateProfileProgress == false,
                                  replacement: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  child: ElevatedButton(
                                    onPressed:(){
                                      updateProfile();
                                      Get.find<AuthController>().getUserInformation();
                                    },
                                    child:
                                    const Icon(Icons.arrow_circle_right_outlined),
                                  ),
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    if (_formKey.currentState!.validate()) {
      bool response=await Controller.updateProfile(
          _firstNameTEController.text.trim(),
          _lastNameTEController.text.trim(),
          _mobileTEController.text.trim(),
          _emailTEController.text.trim(),
          _passwordTEController.text.trim(),
          photo!,
      );
      if (response) {
        if (mounted) {
          SnackMessage(context,Controller.message);
        }
      } else {
        if (mounted) {
          SnackMessage(context,Controller.message);
        }
      }
    }
  }
  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GetBuilder<EditProfileController>(
              builder: (controller) {
                return InkWell(
                  onTap: () async {
                    final XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.camera, imageQuality: 50);
                    if (image != null) {
                      photo = image;
                     controller.update();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Visibility(
                      visible: photo == null,
                      replacement: Text(photo?.name ?? ''),
                      child: const Text('Select a photo'),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
  bool _isValidEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}