import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

class SignUpScreenController extends GetxController{
  bool _inProgress=false;
  String _message='';
  String get message=>_message;
  bool get inProgress=>_inProgress;
  Future<bool> signUp(String email,String firstName,String lastName,String mobile,String password) async {
      _inProgress = true;
     update();
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.registration, body: {
        "email":email,
        "firstName":firstName,
        "lastName":lastName,
        "mobile":mobile,
        "password":password ,
        "photo": "",
      });
      _inProgress = false;
       update();
      if (response.statusCode == 200) {
          _message= "Successfully SignUp go to login";
         return true;
      } else {
          _message= "Log in failed! please try again";
        }
      return false;
  }
}