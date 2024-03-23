import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';
import 'package:rest_api_crud_1/ui/screens/new_task_screen.dart';
import 'package:rest_api_crud_1/ui/widgets/body_background.dart';
import 'package:rest_api_crud_1/ui/widgets/profile_summary_card.dart';
import 'package:rest_api_crud_1/ui/widgets/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key,
    required this.gettasklist,
    required this.getTaskstatusCount,
  });
    final VoidCallback gettasklist;
    final VoidCallback getTaskstatusCount;
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  NewTasksScreen callgetFunction= NewTasksScreen();
   bool _logInProgress=false;
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
                                child: Visibility(
                                  visible: _logInProgress==false,
                                  replacement: const Center(child: CircularProgressIndicator(),),
                                  child: ElevatedButton(
                                    onPressed:(){
                                      addNewTask();
                                      widget.gettasklist();
                                      widget.getTaskstatusCount();
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.arrow_circle_right_outlined),
                                  ),
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
  Future<void>addNewTask()async{
    if(_formKey.currentState!.validate()){
      _logInProgress=true;
      setState(() {});
     final NetworkResponse response=await NetworkCaller().postRequest(Urls.creatTask,body: {
        "title":_subjectTEController.text.trim(),
        "description":_descriptionTEController.text.trim(),
        "status":"New"
      });
      _logInProgress=false;
      setState(() {});
      if(response.isSuccess){
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if(mounted) {
          SnackMessage(context,
              "Successfully Added this task");
        }
      }
      else{
        if(mounted){
          SnackMessage(context,"Can't Added task!!try again",apiCallSuccess: false);
        }
      }
    }
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
