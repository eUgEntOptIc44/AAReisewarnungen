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

  Future<int> insertCountry(List<Country> countries) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var country in countries) {
      result = await db.insert('Countries', country.toMap());
    }
    return result;
  }

  Future<List<Country>> retrieveCountries() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('Countries');
    return queryResult.map((e) => Country.fromMap(e)).toList();
  }

  Future<void> deleteCountry(int id) async {
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