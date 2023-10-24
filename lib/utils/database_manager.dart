import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DB_LocalLibrary {
  @required
  final int id = 0;
  @required
  final String songname = '';
  @required
  final String author = '';
  @required
  final String genre = '';
  @required
  final String dateModified = '';

  // ar.fromDb(Map<String, dynamic> map)
  //     : id = map['id'],
  //       songname = map['songname'],
  //       author = map['author'],
  //       genre = map['genre'],
  //       //isElectro = map['is_electro'] == 1;
  //   dateModified = map['dateModified'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['songname'] = songname;
    map['author'] = author;
    map['genre'] = genre;
    map['dateModified'] = dateModified;
    //map['is_electro'] = isElectro ? 1 : 0;
    return map;
  }
}

class CarDatabase {
  static final CarDatabase _instance = CarDatabase._();
  static Database _database;
  CarDatabase._();

  factory CarDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    Future<Database> database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE car(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      model TEXT,
      power INTEGER,
      top_speed INTEGER,
      is_electro INTEGER)
  ''');
    print("Database was created!");
  }
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }
}