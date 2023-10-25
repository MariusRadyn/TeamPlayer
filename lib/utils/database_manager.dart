import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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

class DatabaseHelper {
  // Make it a Singleton Class
  DatabaseHelper._();
  static final DatabaseHelper _instance = DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  //static Database _database;
  // Future<Database> get db async {
  //   if (_database != null) {
  //     return _database;
  //   }
  //   _database = await init();
  //   return _database;
  // }
  Future<Database> get db async{
  return await init();
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'LocalDB.db');
    Future<Database> database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE SongsTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      songname TEXT,
      author TEXT,
      genre TEXT,
      dateModified TEXT)
  ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }
}