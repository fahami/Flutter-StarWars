import 'dart:convert';
import 'dart:developer';

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
        name TEXT,
        height TEXT,
        mass TEXT,
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
        url TEXT PRIMARY KEY,
        isFavorite BOOL DEFAULT FALSE
        )
      ''');
    }, version: 1);
    print(db);
    return db;
  }

  Future<List<People>> getPeoples() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tablePeoples);
    return results.map((people) {
      return People(
        birthYear: people['birth_year'],
        created: people['created'],
        edited: people['edited'],
        eyeColor: people['eye_color'],
        films: json.decode(people['films']),
        gender: people['gender'],
        hairColor: people['hair_color'],
        height: people['height'].toString(),
        homeworld: people['homeworld'],
        mass: people['mass'].toString(),
        name: people['name'],
        skinColor: people['skin_color'],
        species: json.decode(
          people['species'],
        ),
        starships: json.decode(
          people['starships'],
        ),
        url: people['url'],
        vehicles: json.decode(
          people['vehicles'],
        ),
      );
    }).toList();
  }

  Future<void> savePeople(
    People people,
  ) async {
    final db = await database;
    await db!.insert(_tablePeoples, people.toJson()).catchError((err) {
      log(err);
    });
  }

  Future<void> updatePeople(People people, String url) async {
    final db = await database;
    await db!.update(_tablePeoples, people.toJson(),
        where: 'url = ?', whereArgs: [url]).catchError((err) {
      log(err);
    });
  }

  Future<void> setFavorite(bool favorite, String url) async {
    final db = await database;
    db!
      ..rawUpdate("UPDATE peoples SET isFavorite = $favorite WHERE url = $url")
          .catchError((err) {
        log(err);
      });
  }

  Future<void> deletePeople(String url) async {
    final db = await database;
    await db!.delete(_tablePeoples, where: 'url=?', whereArgs: [url]);
  }

  Future<void> removeDatabase() async {
    final db = await database;
    await db!.delete(_tablePeoples);
  }

  Future<List<People>> searchPeople(String query) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!
        .rawQuery("SELECT * FROM $_tablePeoples WHERE name LIKE '%$query%'");
    return results.map((people) {
      return People(
        birthYear: people['birth_year'],
        created: people['created'],
        edited: people['edited'],
        eyeColor: people['eye_color'],
        films: json.decode(people['films']),
        gender: people['gender'],
        hairColor: people['hair_color'],
        height: people['height'].toString(),
        homeworld: people['homeworld'],
        mass: people['mass'].toString(),
        name: people['name'],
        skinColor: people['skin_color'],
        species: json.decode(
          people['species'],
        ),
        starships: json.decode(
          people['starships'],
        ),
        url: people['url'],
        vehicles: json.decode(
          people['vehicles'],
        ),
        isFavorite: people['isFavorite'],
      );
    }).toList();
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
