import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/edit_profile_controller.dart';
import 'package:rest_api_crud_1/ui/screens/edit_profile_screen.dart';
import 'package:rest_api_crud_1/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  AuthController controller=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return ListTile(
          onTap: () {
            if (widget.enableOnTap) {
             Get.to(const EditProfileScreen());
            }
          },
          leading: CircleAvatar(
            child: controller.user?.photo != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.memory(
                base64Decode(controller.user!.photo!),
                fit: BoxFit.cover,
              ),
            )
                : const Icon(Icons.person),
          ),
          title: Text(
            "${controller.user?.firstName} ${controller.user?.lastName}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "${controller.user?.email}",
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            onPressed: () async {
              await AuthController.clearAuthData();
              Get.offAll(const LoginScreen());
            },
            icon: const Icon(Icons.logout),
          ),
          tileColor: Colors.cyanAccent,
        );
      }
    );
  }
}
