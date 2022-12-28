import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/model/datamodel/todo_model.dart';
import 'package:todolist/model/repository/user_task_repository.dart';
import 'package:todolist/utils/constant.dart';

class TaskListViewModel with ChangeNotifier {
  List<ToDoModel> incomplete = [], complete = [];
  bool focusOnTaskTitle = false, focusOnTaskDetails = false;
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = DateFormat("MMM dd,yyyy");

  //get date wise task
  getDateWiseTask(DateTime? dateTime) async {
    if (dateTime != null) {
      currentDate = dateTime;
      notifyListeners();
      DateTime dateTimeFrom = dateTime,
          dateTimeTo = dateTime.add(const Duration(days: 1));
      DateFormat dateFormat = DateFormat("dd-mm-yyyy");
      complete = (await UserTask()
          .readDateSpecificCompleteTaskData(dateTimeFrom, dateTimeTo));
      incomplete = (await UserTask()
          .readDateSpecificIncompleteTaskData(dateTimeFrom, dateTimeTo));
      notifyListeners();
    }
  }

  //get today's complete and incomplete task
  getCompleteAndIncompleteData() async {
    complete = (await UserTask().readTodayCompleteTaskData());
    incomplete = (await UserTask().readTodayInCompleteTaskData());
    notifyListeners();
  }

  //check if no task available
  checkNoTaskAvailablity() {
    if (complete.isEmpty && incomplete.isEmpty) {
      return false;
    }
    return true;
  }

  deleteIncompleteTask(int incompleteIndex, BuildContext context) async {
    await UserTask()
        .deleteData(incomplete[incompleteIndex].taskId!)
        .then((value) {
      incomplete.removeAt(incompleteIndex);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Task Deleted",
          style: TextStyle(color: Colors.white),
        ),
      ));
    });

    notifyListeners();
  }

  deleteCompletedTask(int completeIndex, BuildContext context) async {
    await UserTask().deleteData(complete[completeIndex].taskId!).then((value) {
      complete.removeAt(completeIndex);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Task Deleted",
          style: TextStyle(color: Colors.white),
        ),
      ));
    });
    notifyListeners();
  }

  // check box change for incomplete task list
  changeIncompleteTaskCheckBox(int incompleteTaskIndex) {
    updateTaskStatus(incomplete[incompleteTaskIndex].taskId!, true);
    notifyListeners();
  }

  // check box change for Complete task list
  changeCompleteTaskCheckBox(int completeTaskIndex) {
    updateTaskStatus(complete[completeTaskIndex].taskId!, false);
    notifyListeners();
  }

// update the complete/incomplete status of task
  updateTaskStatus(int rowId, bool status) async {
    await UserTask().updateTaskStatus(rowId, status).then((value) {
      getDateWiseTask(currentDate);
    });
  }

  navigateToTaskCreatePage(BuildContext context) {
    Navigator.pushNamed(context, Constant.createTask);
  }

  navigateToTaskCreatePageWithData(BuildContext context, ToDoModel toDoModel) {
    Navigator.pushNamed(context, Constant.createTask,
        arguments: {Constant.todoModel: toDoModel});
  }

  getFormattedDate() {
    return dateFormat.format(currentDate);
  }
}
