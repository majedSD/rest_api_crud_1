import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    try {
      String? photoBase64 = AuthController.user?.photo;
      if (photoBase64 != null && photoBase64.isNotEmpty) {
        imageBytes = const Base64Decoder().convert(photoBase64);
      }
    } catch (e) {
      // Handle error or invalid base64 string
      print("Error decoding base64 image: $e");
    }

    return ListTile(
      onTap: () {
        if (widget.enableOnTap) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditProfileScreen()));
        }
      },
      leading: CircleAvatar(
        child: imageBytes == null
            ? const Icon(Icons.person)
            : ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        "${AuthController.user?.firstName} ${AuthController.user?.lastName}",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "${AuthController.user?.email}",
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
          }
        },
        icon: const Icon(Icons.logout),
      ),
      tileColor: Colors.cyanAccent,
    );
  }
}
