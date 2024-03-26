import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/progress_task_screen_controller.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  ProgressTaskScreenController controller=Get.find<ProgressTaskScreenController>();
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
              child: GetBuilder<ProgressTaskScreenController>(
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
