import 'package:get/get.dart';
import 'package:rest_api_crud_1/data/models/task_count_summary_list_model.dart';
import 'package:rest_api_crud_1/data/models/task_list_model.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

class NewTaskScreenController extends GetxController{
  bool _circularProgress=false;
  bool _linearProgressIndicator = false;
  TaskListModel _taskListModel = TaskListModel();
  TaskCountSummaryListModel _taskCountSummaryListModel =
  TaskCountSummaryListModel();
  bool get circularProgress=>_circularProgress;
  TaskListModel get taskListModel=>_taskListModel;
  bool get linearProgressIndicator=>_linearProgressIndicator;
  TaskCountSummaryListModel get taskCountSummaryListModel=>_taskCountSummaryListModel;
  Future<void> getTaskList() async {
      _circularProgress = true;
      update();
    NetworkResponse response =
    await NetworkCaller().getRequest('${Urls.listTaskByStatus}/New');
    if (response.statusCode == 200) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
      _circularProgress = false;
    update();
  }
  Future<void> getTaskStatusCount() async {
      _linearProgressIndicator = true;
       update();
    NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.statusCode == 200) {
      _taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
      _linearProgressIndicator = false;
      update();
  }
}