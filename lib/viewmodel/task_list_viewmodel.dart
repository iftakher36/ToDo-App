import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todolist/model/datamodel/todo_model.dart';
import 'package:todolist/model/repository/user_task_repository.dart';
import 'package:todolist/utils/constant.dart';

class TaskListViewModel with ChangeNotifier {
  List<ToDoModel> incomplete = [], complete = [];
  bool focusOnTaskTitle = false, focusOnTaskDetails = false;
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = DateFormat("MMM dd,yyyy");

  getCompleteAndIncompleteData() async {
    complete = (await UserTask().readTodayCompleteTaskData());
    incomplete = (await UserTask().readTodayInCompleteTaskData());
    notifyListeners();
  }

  changeIncompleteTaskCheckBox(int incompleteTaskIndex) {
    updateTaskStatus(incomplete[incompleteTaskIndex].taskId!, true);
    notifyListeners();
  }
  changeCompleteTaskCheckBox(int completeTaskIndex) {
    updateTaskStatus(complete[completeTaskIndex].taskId!, false);
    notifyListeners();
  }
  updateTaskStatus(int rowId, bool status) async {
    await UserTask().updateTaskStatus(rowId, status).then((value) {
      getCompleteAndIncompleteData();
    });
  }

  navigateToTaskCreatePage(BuildContext context) {
    Navigator.pushNamed(context, Constant.createTask);
  }
  navigateToTaskCreatePageWithData(BuildContext context,ToDoModel toDoModel){
    Navigator.pushNamed(context, Constant.createTask,arguments: {Constant.todoModel: toDoModel});

  }

  getFormattedDate() {
    return dateFormat.format(currentDate);
  }
}
