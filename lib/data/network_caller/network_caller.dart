import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_crud_1/app.dart';
import 'package:rest_api_crud_1/ui/controllers/auth_controller.dart';
import 'package:rest_api_crud_1/ui/screens/login_screen.dart';

import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>?body, bool?isLogin = false}) async {
    try {
      final Response response = await post(
          Uri.parse(url), body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
            "Token": AuthController.token.toString()
          }
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            statusCode: 200,
            jsonResponse: jsonDecode(response.body)
        );
      }
     else if (response.statusCode == 401) {
        if(isLogin==false){
          backToLogin();
        }
        return NetworkResponse(
            isSuccess: false,
            statusCode: 401,
            jsonResponse: jsonDecode(response.body)
        );
      }
      else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body)
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Token": AuthController.token.toString()
          }
      );
      if (response.statusCode == 200) {
        log(AuthController.token.toString());
        return NetworkResponse(
            isSuccess: true,
            statusCode: 200,
            jsonResponse: jsonDecode(response.body)
        );
      }
      else if (response.statusCode == 401) {
          backToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: 401,
            jsonResponse: jsonDecode(response.body)
        );
      }
      else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body)
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
  Future<void> backToLogin()async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
        FlutterTaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()), (
        route) => false);
  }
}
