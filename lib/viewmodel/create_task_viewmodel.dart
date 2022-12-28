import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todolist/model/datamodel/todo_model.dart';
import 'package:todolist/model/repository/user_task_repository.dart';

class CreateTaskViewModel with ChangeNotifier {
  bool focusOnTaskTitle = false,
      focusOnTaskDetails = false;
  DateTime currentDate = DateTime.now();
  DateFormat dateFormat = DateFormat("MMM dd,yyyy");


  //create task
  insertNewTask(String title, String details) async {
    ToDoModel toDoModel = ToDoModel(taskId: null,
        taskTitle: title,
        taskDetails: details,
        isCompleted: false,
        createDate: currentDate);
    final id = await UserTask().insertData(toDoModel);
    print(id);
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

  //popping the current page
  finishPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  //get currentFormatted date
  getFormattedDate() {
    return dateFormat.format(currentDate);
  }

  @override
  void dispose() {
    focusOnTaskTitle = false;
    focusOnTaskDetails = false;
    super.dispose();
  }
}
