import 'package:flutter/material.dart';

void SnackMessage(BuildContext context, message, { bool? apiCallSuccess}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:Text("$message"),
      backgroundColor:(apiCallSuccess==false)?Colors.redAccent:Colors.green,
    ),
  );
}
