import 'package:get/get.dart';
import 'package:rest_api_crud_1/data/models/user_model.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';

class LoginController extends GetxController{
 bool _loginInprogress=false;
 String _message='';
 bool get loginProgress=>_loginInprogress;
 String get message=>_message;
  Future<bool>postLoginRequest(String email,String password)async{
      _loginInprogress=true;
      update();
      NetworkResponse response=await NetworkCaller().postRequest(Urls.login,body: {
        "email":email,
        "password":password,
      },isLogin:true);
      _loginInprogress=false;
      update();
      if(response.statusCode==200){
       update();
        Get.find<AuthController>().setUserInformation(response.jsonResponse['token'],UserModel.fromJson(response.jsonResponse['data']));
         _message= "Login Successfully completed";
         return true;
      }
      else{
        if(response.statusCode==401) {
          _message = "Please check email/password";
          }
        else{
          _message='Login failed! try again';
        }
        }
      return false;
      }
  }