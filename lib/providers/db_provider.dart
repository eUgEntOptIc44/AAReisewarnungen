import 'dart:io';
import 'package:aareisewarnungen/data/country_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    //String path = await getDatabasesPath();
    return openDatabase(
      //join(path, 'countries.db'),
      'countries.db',
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE Countries('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'lastModified INTEGER,'
          'lastModified effective,'
          'flagUrl TEXT,'
          'title TEXT,'
          'warning INTEGER,'
          'partialWarning INTEGER,'
          'situationWarning INTEGER,'
          'lastChanges TEXT,'
          'content TEXT'
          ')',
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('Countries', user.toMap());
    }
    return result;
  }

  Future<List<User>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Countries');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      'Countries',
      where: "id = ?",
      whereArgs: [
        id
      ],
    );
  }
}

/*
class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Countries table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'countries.db');

    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Countries('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'lastModified INTEGER,'
          'lastModified effective,'
          'flagUrl TEXT,'
          'title TEXT,'
          'warning TEXT,'
          'partialWarning TEXT,'
          'situationWarning TEXT,'
          'lastChanges TEXT,'
          'content TEXT'
          ')');
    });
  }

  createCountry(User newCountry) async {
    final db = await database;
    final res = await db.insert('Countries', newCountry.toJson());

    return res;
  }

  // Insert Countries on database
  createCountries(User newCountries) async {
    await deleteAllCountries();
    final db = await database;
    final res = await db.insert('Countries', newCountries.toJson());

    return res;
  }

  // Delete all Countries
  Future<int> deleteAllCountries() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Countries');

    return res;
  }

  Future<List<User>> getAllCountries() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Countries");

    List<User> list = res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];

    return list;
  }
}
*/
