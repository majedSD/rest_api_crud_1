import 'package:flutter/material.dart';
import 'package:rest_api_crud_1/data/models/task.dart';
import 'package:rest_api_crud_1/data/network_caller/network_caller.dart';
import 'package:rest_api_crud_1/data/network_caller/network_response.dart';
import 'package:rest_api_crud_1/data/utility/urls.dart';

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    Key? key,
    this.task,
    required this.callbackFunction,
  }) : super(key: key);

  final Task? task;
  final VoidCallback callbackFunction;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  bool _isLoading = false;

  Future<void> getupdateTaskStatus(String status) async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller().getRequest(
        '${Urls.updateTaskStatus}/${widget.task?.sId}/$status');
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      widget.callbackFunction();
      print(response.statusCode);
    }
  }

  Future<void> getdeletTask() async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller()
        .getRequest('${Urls.deleteTask}/${widget.task?.sId}');
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      widget.callbackFunction();
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task!.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            Text(widget.task!.description.toString()),
            Text("Date:${widget.task!.createdDate}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task!.status.toString(),
                  ),
                  backgroundColor: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        updateTaskStatus();
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        getdeletTask();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateTaskStatus() async {
    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    List<ListTile> items = TaskStatus.values
        .map(
          (e) => ListTile(
        onTap: () async {
          // Call the update task status method
          await getupdateTaskStatus(e.name);
          if(mounted) {
            Navigator.pop(context);
        }
        },
        title: Text(e.name),
      ),
    )
        .toList();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Update Status",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("Cancel"),
                )
              ],
            ),
          ],
        );
      },
    ).whenComplete(() {
      // Hide loading indicator when dialog is closed
      setState(() {
        _isLoading = false;
      });
    });
  }
}

enum TaskStatus {
  New,
  Progress,
  Complete,
  Cancelled
}
