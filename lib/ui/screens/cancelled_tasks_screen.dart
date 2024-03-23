import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/data/models/task_list_model.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  bool circularProgress=false;
  @override
  void initState(){
    super.initState();
    getTaskList();
  }
  TaskListModel taskListModel=TaskListModel();
  Future<void>getTaskList()async{
    circularProgress=true;
    if(mounted) {
      setState(() {});
    }
    NetworkResponse response=await NetworkCaller().getRequest('${Urls.listTaskByStatus}/Cancelled');
    if(response.statusCode==200){
      taskListModel=TaskListModel.fromJson(response.jsonResponse);
    }
    circularProgress=false;
    if(mounted){
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: Visibility(
                visible:circularProgress==false,
                replacement:const Center(child: CircularProgressIndicator(),),
                child: RefreshIndicator(
                  onRefresh:getTaskList,
                  child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                            task:taskListModel.taskList![index],
                          callbackFunction:(){
                              getTaskList();
                          },
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
