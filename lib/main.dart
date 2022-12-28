import 'package:flutter/material.dart';
import 'package:todolist/utils/apptheme.dart';
import 'package:todolist/utils/constant.dart';
import 'package:todolist/view/create_task.dart';
import 'package:todolist/view/task_list.dart';
import 'package:provider/provider.dart';
import 'package:todolist/viewmodel/create_task_viewmodel.dart';
import 'package:todolist/viewmodel/task_list_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateTaskViewModel()),
        ChangeNotifierProvider(create: (_) => TaskListViewModel()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDo App',
          theme: AppTheme.lightTheme,
          routes: {
            Constant.taskList: (ctx) => const TaskList(),
            Constant.createTask: (ctx) => const CreateTask()
          }),
    );
  }
}
