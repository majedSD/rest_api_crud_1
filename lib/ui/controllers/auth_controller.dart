import 'dart:convert';

import 'package:rest_api_crud_1/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController{
  static String?token;
 static UserModel?user;
 static Future<void>setUserInformation(String t,UserModel model)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString('token',t);
    sharedPreferences.setString('user',jsonEncode(model.toJson()));
    await getUserInformation();
  }
  static Future<void>updateUserInformation(UserModel model)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString('user',jsonEncode(model.toJson()));
    await getUserInformation();
  }
 static Future<void>getUserInformation()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    token=sharedPreferences.getString('token');
    user=UserModel.fromJson(jsonDecode(sharedPreferences.getString('user')??'{}'));
  }
 static Future<void>clearAuthData()async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences.clear();
   token=null;
 }
 static Future<bool>checkAuthState()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String?token=sharedPreferences.getString('token');
    if(token!=null){
      await getUserInformation();
      return true;
    }
    return false;
  }
}