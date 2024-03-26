import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/new_task_screen_controller.dart';

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
  final NewTaskScreenController _newTaskScreenController=Get.find<NewTaskScreenController>();

  @override
  void initState() {
    super.initState();
    _newTaskScreenController.getTaskList();
    //Get.find<NewTaskScreenController>().getTaskList();
    _newTaskScreenController.getTaskStatusCount();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Get.to(const AddNewTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            GetBuilder<NewTaskScreenController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.linearProgressIndicator == false,
                  replacement: const LinearProgressIndicator(),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.taskCountSummaryListModel.taskCountList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return FittedBox(
                          child: SummaryCard(
                            count: controller.taskCountSummaryListModel.taskCountList![index].sId.toString(),
                            title: controller.taskCountSummaryListModel.taskCountList![index].sum.toString(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            ),
            Expanded(
              child: GetBuilder<NewTaskScreenController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.circularProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh:()=>controller.getTaskList(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: controller.taskListModel.taskList![index],
                            callbackFunction: () {
                              controller.getTaskList();
                              controller.getTaskStatusCount();
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
