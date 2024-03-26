import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/completed_task_screen_controller.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  CompletedTaskScreenController controller=Get.find<CompletedTaskScreenController>();
  @override
  void initState(){
    super.initState();
    controller.getTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<CompletedTaskScreenController>(
                builder: (controller) {
                  return Visibility(
                    visible:controller.circularProgress==false,
                    replacement:const Center(child: CircularProgressIndicator(),),
                    child: RefreshIndicator(
                      onRefresh: controller.getTaskList,
                      child: ListView.builder(
                          itemCount: controller.taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskItemCard(
                                task:controller.taskListModel.taskList![index],
                              callbackFunction: (){
                                  controller.getTaskList();
                              },
                            );

                          }),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
