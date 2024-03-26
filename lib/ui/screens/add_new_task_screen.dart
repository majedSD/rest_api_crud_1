import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_crud_1/ui/controllers/add_new_task_controller.dart';
import 'package:rest_api_crud_1/ui/controllers/new_task_screen_controller.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/profile_summary_card.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key,
  });
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  AddNewTaskController controller=Get.find<AddNewTaskController>();
  Future<void>addNewTask()async{
    if(_formKey.currentState!.validate()){
      final bool response=await controller.addNewTask(_subjectTEController.text.trim(),_descriptionTEController.text.trim());
      if(response){
        Get.find<NewTaskScreenController>().getTaskList();
        Get.find<NewTaskScreenController>().getTaskStatusCount();
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if(mounted) {
          SnackMessage(context,controller.message);
        }
      }
      else{
        if(mounted){
          SnackMessage(context,controller.message,apiCallSuccess: false);
        }
      }
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
              child: BodyBackground(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            Text(
                              "Add New Task",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _subjectTEController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: "Subject",
                              ),
                              validator: Validator,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _descriptionTEController,
                              keyboardType:TextInputType.text,
                              textInputAction: TextInputAction.next,
                              maxLines: 6,
                              decoration: const InputDecoration(
                                hintText: "Description",
                              ),
                              validator: Validator,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            SizedBox(
                                height: 50,
                                width: double.infinity,
                                child:GetBuilder<AddNewTaskController>(
                                  builder: (controller) {
                                    return Visibility(
                                      visible:controller.logInProgress==false,
                                      replacement: const Center(child: CircularProgressIndicator(),),
                                      child: ElevatedButton(
                                        onPressed:(){
                                          addNewTask();
                                         Get.back();
                                        },
                                        child: const Icon(Icons.arrow_circle_right_outlined),
                                      ),
                                    );
                                  }
                                ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
  String? Validator(String? value) {
    if (value!.trim().isEmpty) {
      return "Enter a valid value";
    }
  }
  @override
  void dispose(){
    super.dispose();
    _descriptionTEController.clear();
    _subjectTEController.clear();
  }
}
