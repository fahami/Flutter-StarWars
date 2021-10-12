import 'package:sqflite/sqflite.dart';
import 'package:starwars/models/people.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  static String _tablePeoples = 'peoples';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database?> get database async => _database ?? await _initializeDb();

  Future<Database?> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/starwars.db', onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $_tablePeoples (
        id TEXT PRIMARY KEY,
        name TEXT,
        height INTEGER,
        mass INTEGER,
        hair_color TEXT,
        skin_color TEXT,
        eye_color TEXT,
        birth_year TEXT,
        gender TEXT,
        homeworld TEXT,
        films TEXT,
        species TEXT,
        vehicles TEXT,
        starships TEXT,
        created TEXT,
        edited TEXT,
        url TEXT,
        )
      ''');
    }, version: 1);
    return db;
  }

  Future<List<People>> getPeoples() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tablePeoples);
    return results.map((people) {
      print(people);
      return People.fromJson(people);
    }).toList();
  }

  Future<void> savePeople(People people) async {
    final db = await database;
    await db!.insert(_tablePeoples, people.toJson());
  }

  Future<void> deletePeople(String id) async {
    final db = await database;
    await db!.delete(_tablePeoples, where: 'id=?', whereArgs: [id]);
  }

  Future<void> removeDatabase() async {
    final db = await database;
    await db!.delete(_tablePeoples);
  }

  Future<bool?> isExist(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(
      _tablePeoples,
      where: 'id=?',
      whereArgs: [id],
    );
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}