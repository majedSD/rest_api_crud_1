import 'dart:convert';

import 'package:get/get.dart';
import 'package:rest_api_crud_1/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  static String?token;
  UserModel?user;
  Future<void>setUserInformation(String t,UserModel model)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString('token',t);
    sharedPreferences.setString('user',jsonEncode(model.toJson()));
    await getUserInformation();
    update();
  }
   Future<void>updateUserInformation(UserModel model)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString('user',jsonEncode(model.toJson()));
    await getUserInformation();
    update();
  }
  Future<void>getUserInformation()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    token=sharedPreferences.getString('token');
    user=UserModel.fromJson(jsonDecode(sharedPreferences.getString('user')??'{}'));
    update();
  }
  static Future<void>clearAuthData()async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences.clear();
   token=null;
 }
  Future<bool>checkAuthState()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String?token=sharedPreferences.getString('token');
    if(token!=null){
      await getUserInformation();
      return true;
    }
    return false;
  }
}