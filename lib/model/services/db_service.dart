import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../utils/constant.dart';

class DbService {
  static DbService dbService = DbService._init();
  static Database? _database;
  String dbIntPrimaryType = "INTEGER PRIMARY KEY AUTOINCREMENT";
  String dbBoolType = "BOOLEAN NOT NULL";
  String dbTextType = "TEXT";

  DbService._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await getDb();
      return _database!;
    }
  }

  Future<Database> getDb() async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'todo_database.db'),
            onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE ${Constant.tblName}(${Constant.rowId} $dbIntPrimaryType,${Constant.taskTitle} $dbTextType,"
          "${Constant.taskDetails} $dbTextType,${Constant.createDate} $dbTextType)");
    }, version: 1, onUpgrade: _onUpgrade);
    return database;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Add different query for adding new column,
      // Don't forget to add new column in onCreate
    }
  }
}
