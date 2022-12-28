import 'package:flutter/cupertino.dart';
import 'package:todolist/utils/constant.dart';

class TaskListViewModel with ChangeNotifier {
  navigateToTaskCreatePage(BuildContext context) {
    Navigator.pushNamed(context, Constant.createTask);
  }
}
