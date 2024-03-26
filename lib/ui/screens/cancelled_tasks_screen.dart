import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/cancelled_task_screen_controller.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  CancelledTaskScreenController controller=Get.find<CancelledTaskScreenController>();
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
              child: GetBuilder<CancelledTaskScreenController>(
                builder: (controller) {
                  return Visibility(
                    visible:controller.circularProgress==false,
                    replacement:const Center(child: CircularProgressIndicator(),),
                    child: RefreshIndicator(
                      onRefresh:controller.getTaskList,
                      child: ListView.builder(
                          itemCount: controller.taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskItemCard(
                                task:controller.taskListModel.taskList![index],
                              callbackFunction:(){
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
