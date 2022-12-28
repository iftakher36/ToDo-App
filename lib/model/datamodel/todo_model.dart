import 'dart:convert';

import '../../utils/constant.dart';

ToDoModel emptyFromJson(String str) => ToDoModel.fromJson(json.decode(str));

String todoToJson(ToDoModel data) => json.encode(data.toJson());

class ToDoModel {
  int? taskId;
  String taskTitle;
  String taskDetails;
  DateTime createDate;
  bool isCompleted;

  ToDoModel(
      {required this.taskId,
      required this.taskTitle,
      required this.taskDetails,
      required this.isCompleted,
      required this.createDate});

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        taskId: json[Constant.rowId],
        taskTitle: json[Constant.taskTitle],
        taskDetails: json[Constant.taskDetails],
        isCompleted: json[Constant.isTaskCompleted] == 1,
        createDate: DateTime.parse(json[Constant.createDate] as String),
      );

  Map<String, dynamic> toJson() => {
        Constant.rowId: taskId,
        Constant.taskTitle: taskTitle,
        Constant.taskDetails: taskDetails,
        Constant.isTaskCompleted: isCompleted ? 1 : 0,
        Constant.createDate: createDate.toIso8601String()
      };
}
