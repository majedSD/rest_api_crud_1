import 'package:rest_api_crud_1/data/models/task.dart';

class TaskListModel {
  String? status;
   List<Task>? taskList;

  TaskListModel({this.status, taskList});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <Task>[];
      json['data'].forEach((v) {
        taskList!.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskList != null) {
      data['data'] = taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
