import 'package:sqflite_cipher_encryption/helper/db_helper.dart';

class UserDao {
  static Future insertData(Map<String, dynamic> data) async {
    final db = await DbHelper.intance.database;
    await db.insert('USER', data);
  }

  static Future<List<Map<String, Object?>>> getData() async {
    final db = await DbHelper.intance.database;
    final userData = await db.query("USER");
    return userData;
  }
}
