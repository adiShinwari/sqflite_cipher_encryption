import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../main.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper _instance = DbHelper._();

  static DbHelper get intance => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'encrypted.db');
    return await openDatabase(path,
        password: dotEnv.env['password'].toString(),
        version: 1,
        onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE USER (
            id INTEGER AUTO INCREMENT PRIMARY KEY ,
            name TEXT NOT NULL,
            age INTEGER NOT NULL
          )
          ''');
  }
}
