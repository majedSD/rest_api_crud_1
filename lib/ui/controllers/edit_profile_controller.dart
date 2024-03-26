import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_api_crud_1/data/models/user_model.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

import 'auth_controller.dart';

class EditProfileController extends GetxController{
  bool _updateProfileInProgress=false;
  String _message='';
  String get message=>_message;
  bool get updateProfileProgress=>_updateProfileInProgress;
  Future<bool> updateProfile(String firstName,String lastName,String mobile,String email,String password,XFile photo) async {
      _updateProfileInProgress = true;
     update();
      String? photoInBase64;
      Map<String, dynamic> inputData = {
        "firstName": firstName,
        "lastName" : lastName,
        "email" : email,
        "mobile": mobile,
      };

      if (password.isNotEmpty) {
        inputData['password'] =password;
      }
      if (photo != null){
        List<int> imageBytes = await photo!.readAsBytes();
        photoInBase64 = base64Encode(imageBytes);
        inputData['photo'] = photoInBase64;
      }
      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.profileUpdate,
        body: inputData,
      );
      _updateProfileInProgress = false;
       update();
      if (response.isSuccess) {
        Get.find<AuthController>().updateUserInformation(UserModel(
            email:email,
            firstName:firstName,
            lastName:lastName,
            mobile: mobile,
            photo: photoInBase64 ?? Get.find<AuthController>().user?.photo
        )); update();
        Get.find<AuthController>().getUserInformation();
        _message='Update profile success!';
        return true;
      } else {
          _message='Update profile failed. Try again.';
      }
      return false;
    }
  }