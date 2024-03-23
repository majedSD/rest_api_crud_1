import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/data/models/task_count_summary_list_model.dart';
import 'package:rest_api_crud_1/data/models/task_list_model.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_item_card.dart';
import 'add_new_task_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool circularProgress = false;
  bool linearProgressIndicator = false;

  TaskListModel taskListModel = TaskListModel();
  TaskCountSummaryListModel taskCountSummaryListModel =
  TaskCountSummaryListModel();

  @override
  void initState() {
    super.initState();
    getTaskList();
    getTaskStatusCount();
  }

  Future<void> getTaskList() async {
    setState(() {
      circularProgress = true;
    });
    NetworkResponse response =
    await NetworkCaller().getRequest('${Urls.listTaskByStatus}/New');
    if (response.statusCode == 200) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    setState(() {
      circularProgress = false;
    });
  }

  Future<void> getTaskStatusCount() async {
    setState(() {
      linearProgressIndicator = true;
    });
    NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.statusCode == 200) {
      taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
    setState(() {
      linearProgressIndicator = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewTaskScreen(
                gettasklist: getTaskList,
                getTaskstatusCount: getTaskStatusCount,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Visibility(
              visible: linearProgressIndicator == false,
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskCountSummaryListModel.taskCountList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return FittedBox(
                      child: SummaryCard(
                        count: taskCountSummaryListModel.taskCountList![index].sId.toString(),
                        title: taskCountSummaryListModel.taskCountList![index].sum.toString(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: circularProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getTaskList,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: taskListModel.taskList![index],
                        callbackFunction: () {
                          getTaskList();
                          getTaskStatusCount();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
