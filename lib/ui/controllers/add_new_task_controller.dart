import 'package:get/get.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

class AddNewTaskController extends GetxController{
  bool _logInProgress=false;
  String _message='';
  bool get logInProgress=>_logInProgress;
  String get message=>_message;
  Future<bool>addNewTask(String subject,String description)async{
      _logInProgress=true;
       update();
      final NetworkResponse response=await NetworkCaller().postRequest(Urls.creatTask,body: {
        "title":subject,
        "description":description,
        "status":"New"
      });
      _logInProgress=false;
       update();
      if(response.isSuccess){
              _message="Successfully Added this task";
              return true;
        }
      else{
     _message="Can't Added task!!try again";
        }
      return false;
      }
  }