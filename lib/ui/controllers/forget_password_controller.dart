import 'package:get/get.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

class ForgetPasswordController extends GetxController{
  String _message='';
  String  _Message='';
  bool _loginProgress=false;
  bool _LoginProgress=false;
  String get message=>_message;
  String get Message=>_Message;
  bool get loginProgress=>_loginProgress;
  bool get LoginProgress=>_LoginProgress;
  Future<bool> getVerifyEmail(String email) async {
    _loginProgress=true;
    update();
    NetworkResponse response = await NetworkCaller()
        .getRequest('${Urls.recoveryVerifyEmail}/$email');
    _loginProgress=false;
    update();
    if (response.isSuccess && response.jsonResponse['status']=='success') {
        _message= 'Successfully Verified Email';
         return true;
    }
    else{
        _message='Email verification failed';
    }
    return false;
  }
  Future<bool> getVerifyOTP(String email,String pincode) async {
    _LoginProgress=true;
    update();
    NetworkResponse response = await NetworkCaller()
        .getRequest('${Urls.recoveryVerifyOTP}/$email/$pincode');
    _LoginProgress=false;
    update();
    if (response.isSuccess && response.jsonResponse['status']=='success') {
        _Message= 'Successfully Send OTP';
      return true;
    }
    else{
        _Message='Send OTP failed! try again';
    }
    return false;
  }
}