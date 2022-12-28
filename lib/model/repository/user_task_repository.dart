import 'package:todolist/model/datamodel/todo_model.dart';

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
  Future<int> updateData(ToDoModel toDoModel) async {
    final db = await await getDb();
    final id = await db.update(
      Constant.tblName,
      toDoModel.toJson(),
      where: '${Constant.rowId} = ?',
      whereArgs: [toDoModel.taskId],
    );
    return id;
  }

  //read today's complete  task
  Future<int> readTodayCompleteTaskData() async {
    final db = await getDb();
    final results = await db.query(
        "select * from ${Constant.tblName} where ${Constant.createDate} IS NOT NULL  and ${Constant.createDate}> DATE('now','localtime') and ${Constant.createDate}< DATE('now', '+1 day','localtime') and ${Constant.isTaskCompleted}= '1' ");
    return results;
  }

  //read today's incomplete task
  Future<int> readTodayInCompleteTaskData() async {
    final db = await getDb();
    final results = await db.query(
        "select * from ${Constant.tblName} where ${Constant.createDate} IS NOT NULL  and ${Constant.createDate}> DATE('now','localtime') and ${Constant.createDate}< DATE('now', '+1 day','localtime') and ${Constant.isTaskCompleted}= '0' ");
    return results;
  }

  Future<int> deleteData(int rowId) async {
    final db = await getDb();
    final id = await db.delete(Constant.tblName,
        where: '${Constant.rowId} = ?', whereArgs: [rowId]);
    return id;
  }
}
