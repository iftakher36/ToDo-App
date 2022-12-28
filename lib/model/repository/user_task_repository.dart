import 'package:todolist/model/datamodel/todo_model.dart';
import 'package:intl/intl.dart';
import '../../utils/constant.dart';
import '../services/db_service.dart';

class UserTask {
  //get singleton references of database
  getDb() async {
    return await DbService.dbService.database;
  }

  //insert data into db
  Future<dynamic> insertData(ToDoModel toDoModel) async {
    final db = await getDb();
    final id = await db.insert(Constant.tblName, toDoModel.toJson());
    return id;
  }

  //update a row of database
  Future<int> updateData(ToDoModel newToDoModel, int oldTaskId) async {
    final db = await getDb();
    final id = await db.update(
      Constant.tblName,
      {
        Constant.taskTitle: newToDoModel.taskTitle,
        Constant.taskDetails: newToDoModel.taskDetails
      },
      where: '${Constant.rowId} = ?',
      whereArgs: [oldTaskId],
    );
    return id;
  }

  //read today's complete  task
  Future<List<ToDoModel>> readTodayCompleteTaskData() async {
    final db = await getDb();
    final results = await db.query(
        " ${Constant.tblName} where ${Constant.createDate} IS NOT NULL  and ${Constant.createDate}> DATE('now','localtime') and ${Constant.createDate}< DATE('now', '+1 day','localtime') and ${Constant.isTaskCompleted}= '1' order by ${Constant.createDate}");
    if (results.isNotEmpty) {
      return List<ToDoModel>.from(
          results.map((json) => ToDoModel.fromJson(json)).toList());
    } else {
      return [];
    }
  }

  //read today's incomplete task
  Future<List<ToDoModel>> readTodayInCompleteTaskData() async {
    final db = await getDb();
    final results = await db.query(
        "${Constant.tblName} where ${Constant.createDate} IS NOT NULL  and ${Constant.createDate}> DATE('now','localtime') and ${Constant.createDate}< DATE('now', '+1 day','localtime') and ${Constant.isTaskCompleted}= '0' order by ${Constant.createDate}");
    if (results.isNotEmpty) {
      return List<ToDoModel>.from(
          results.map((json) => ToDoModel.fromJson(json)).toList());
    } else {
      return [];
    }
  }

  //read date wise incomplete task
  Future<List<ToDoModel>> readDateSpecificIncompleteTaskData(
      DateTime dateTimeFrom, DateTime dateTimeTo) async {
    final db = await getDb();
    final results = await db.query(
        "${Constant.tblName} where ${Constant.createDate} between '$dateTimeFrom' and '$dateTimeTo' and ${Constant.isTaskCompleted}='0' order by ${Constant.createDate}");
    if (results.isNotEmpty) {
      return List<ToDoModel>.from(
          results.map((json) => ToDoModel.fromJson(json)).toList());
    } else {
      return [];
    }
  }


  //read date wise complete task
  Future<List<ToDoModel>> readDateSpecificCompleteTaskData(
      DateTime dateTimeFrom, DateTime dateTimeTo) async {
    final db = await getDb();
    final results = await db.query(
        "${Constant.tblName} where ${Constant.createDate} between '$dateTimeFrom' and '$dateTimeTo' and ${Constant.isTaskCompleted}='1' order by ${Constant.createDate}");
    if (results.isNotEmpty) {
      return List<ToDoModel>.from(
          results.map((json) => ToDoModel.fromJson(json)).toList());
    } else {
      return [];
    }
  }

  //update complete status of task
  Future<int> updateTaskStatus(int rowId, bool status) async {
    final db = await getDb();
    final id = await db.update(
      Constant.tblName,
      {Constant.isTaskCompleted: status},
      where: '${Constant.rowId} = ?',
      whereArgs: [rowId],
    );
    return id;
  }

// delete specific row of database
  Future<int> deleteData(int rowId) async {
    final db = await getDb();
    final id = await db.delete(Constant.tblName,
        where: '${Constant.rowId} = ?', whereArgs: [rowId]);
    return id;
  }
}
