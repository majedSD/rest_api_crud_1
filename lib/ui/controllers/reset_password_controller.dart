import 'package:get/get.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

class ResetPasswordController extends GetxController {
  bool _setPasswordInProgress = false;
  String _message = '';

  String get message => _message;

  bool get setPasswordInProgress => _setPasswordInProgress;

  Future<bool> setNewPassword(String email, String pin, newPassword) async {
    _setPasswordInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.recoverResetPass,
      body: {
        "email": email,
        "OTP": pin,
        "password": newPassword,
      },
    );
    _setPasswordInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    }
    else {
      _message = "Action Failed! Please try again.";
    }
    return false;
  }
}