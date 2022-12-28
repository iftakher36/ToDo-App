import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/model/datamodel/todo_model.dart';
import 'package:todolist/model/repository/user_task_repository.dart';
import 'package:provider/provider.dart';
import 'package:todolist/viewmodel/task_list_viewmodel.dart';

import '../utils/constant.dart';

class CreateTaskViewModel with ChangeNotifier {
  bool focusOnTaskTitle = false, focusOnTaskDetails = false;
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = DateFormat("MMM dd,yyyy");
  ToDoModel? toDoModelRoute;

  //getting data from route while updating task
  getRouteData(BuildContext context) {
    try {
      Map map = ModalRoute.of(context)?.settings.arguments as Map;
      toDoModelRoute = map[Constant.todoModel];
      if (toDoModelRoute != null) {
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //create and update
  insertAndUpdateTask(
      String title, String details, BuildContext context) async {
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Provide a title to your task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
      ));
    } else if (details.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Provide a details to your task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
      ));
    } else {
      ToDoModel toDoModel = ToDoModel(
          taskId: null,
          taskTitle: title,
          taskDetails: details,
          isCompleted: false,
          createDate: currentDate);

      if (toDoModelRoute == null) {
        //newly insert task
        await UserTask().insertData(toDoModel).then((value) {
          if (value > -1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Task Successfully Saved",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            finishPageAndRefresh(context);
          }
        });
      }
      else {
        // updating whole task
        await UserTask().updateData(toDoModel,toDoModelRoute!.taskId!).then((value) {
          if (value > -1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Task updated Successfully",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            finishPageAndRefresh(context);
          }
        });
      }
    }
  }

  //updating the focus status of task title text field
  changeTitleFocus(bool value, int length) {
    if (length > 0) {
      focusOnTaskTitle = true;
    } else {
      focusOnTaskTitle = value;
    }
    notifyListeners();
  }

  //updating the focus status of task details text field
  changeDetailsFocus(bool value, int length) {
    if (length > 0) {
      focusOnTaskDetails = true;
    } else {
      focusOnTaskDetails = value;
    }
    notifyListeners();
  }

  //get currentFormatted date
  getFormattedDate() {
    return dateFormat.format(currentDate);
  }

  //popping the current page
  finishPageAndRefresh(BuildContext context) {
    //finish the page
    finishPage(context);
    //refresh the data
    resetData();
    //refresh for new changes
    Provider.of<TaskListViewModel>(context, listen: false)
        .getCompleteAndIncompleteData();
  }

  finishPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  resetData() {
    toDoModelRoute = null;
    focusOnTaskTitle = false;
    focusOnTaskDetails = false;
    notifyListeners();
  }
}
