import 'package:get/get.dart';
import 'package:rest_api_crud_1/data/models/task_list_model.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

class ProgressTaskScreenController extends GetxController{
  TaskListModel _taskListModel=TaskListModel();
  bool _circularProgress=false;
  TaskListModel get taskListModel=>_taskListModel;
  bool get circularProgress=>_circularProgress;
  Future<void>getTaskList()async{
    _circularProgress=true;
    update();
    NetworkResponse response=await NetworkCaller().getRequest('${Urls.listTaskByStatus}/Progress');
    if(response.statusCode==200){
      _taskListModel=TaskListModel.fromJson(response.jsonResponse);
    }
    _circularProgress=false;
    update();
  }
}