import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:team_player/utils/global_data.dart';

void deleteLocalDB() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String dbPath = join(directory.path, DB_LOCAL);
  deleteDatabase(dbPath);
  print('LOCAL DATABASE DELETED!!!');
}

// Songs Library DB
class SQLHelperSongsLibrary {
  // Make it a Singleton Class
  SQLHelperSongsLibrary._();
  static final SQLHelperSongsLibrary _instance = SQLHelperSongsLibrary._();

  factory SQLHelperSongsLibrary() {
    return _instance;
  }

  Future<Database> get database async{
  return await init();
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, DB_LOCAL);

    Future<Database> database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    print('Opened DB: ' + dbPath);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $DB_TABLE_SONGS_LIB(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      songName TEXT,
      author TEXT,
      genre TEXT,
      dateCreated TEXT,
      dateModified TEXT,
      dateLastViewed TEXT,
      isActive INTEGER)
    ''');

    db.execute('''
    CREATE TABLE $DB_TABLE_PLAYLIST_ITEMS(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      songName TEXT,
      author TEXT,
      genre TEXT)
    ''');

    db.execute('''
    CREATE TABLE $DB_TABLE_PLAYLIST_LIB(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT,
      dateCreated TEXT,
      dateModified TEXT,
      nrOfItems INTEGER)
    ''');

    print("Table created: $DB_TABLE_SONGS_LIB, $DB_TABLE_PLAYLIST_LIB, $DB_TABLE_PLAYLIST_ITEMS");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  static Future<void> insert(LocalSongsLibrary data) async {
    final Database db = await SQLHelperSongsLibrary().database;

    await db.insert(
      DB_TABLE_SONGS_LIB,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(data.toString());
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> readTable() async {
    final Database db = await SQLHelperSongsLibrary().database;
    return db.query(DB_TABLE_SONGS_LIB, orderBy: "id");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperSongsLibrary().database;
    return db.query(DB_TABLE_SONGS_LIB,
        where: "id = ?",
        whereArgs: [id],
        limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String songName, String author) async {
    final db = await SQLHelperSongsLibrary().database;

    final data = {
      'songName': songName,
      'author': author,
      'dateModified': DateTime.now().toString()
    };

    final result =
    await db.update(
        DB_TABLE_SONGS_LIB,
        data,
        where: "id = ?",
        whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperSongsLibrary().database;
    try {
      await db.delete(
          DB_TABLE_SONGS_LIB,
          where: "id = ?",
          whereArgs: [id]);
    } catch (err) {
      print("ERROR Deleting Database item: $err");
    }
  }
}


class SQLHelperPlaylistLibrary {
  // Make it a Singleton Class
  SQLHelperPlaylistLibrary._();
  static final SQLHelperPlaylistLibrary _instance = SQLHelperPlaylistLibrary._();

  factory SQLHelperPlaylistLibrary() {
    return _instance;
  }

  Future<Database> get database async{
    return await init();
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, DB_LOCAL);

    // Only run this to start from fresh
    //deleteDatabase(dbPath);

    Future<Database> database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    print('Opened DB: ' + dbPath);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $DB_TABLE_PLAYLIST_LIB(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT,
      dateCreated TEXT,
      dateModified TEXT)
    ''');

    print("Table created: " + DB_TABLE_PLAYLIST_LIB);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  static Future<void> insert(LocalPlaylistLibrary data) async {
    final Database db = await SQLHelperPlaylistLibrary().database;

    await db.insert(
      DB_TABLE_PLAYLIST_LIB,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(data.toString());
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> readTable() async {
    final Database db = await SQLHelperPlaylistLibrary().database;
    return db.query(DB_TABLE_PLAYLIST_LIB, orderBy: "id");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperPlaylistLibrary().database;
    return db.query(DB_TABLE_PLAYLIST_LIB,
        where: "id = ?",
        whereArgs: [id],
        limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String desc) async {
    final db = await SQLHelperSongsLibrary().database;

    final data = {
      'description': desc,
      'dateModified': DateTime.now().toString()
    };

    final result =
    await db.update(
        DB_TABLE_SONGS_LIB,
        data,
        where: "id = ?",
        whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperPlaylistLibrary().database;
    try {
      await db.delete(
          DB_TABLE_PLAYLIST_LIB,
          where: "id = ?",
          whereArgs: [id]);
    } catch (err) {
      print("ERROR Deleting Database item: $err");
    }
  }
}

// Database
// Playlist containing songs
class SQLHelperPlaylistItems {
  // Make it a Singleton Class
  SQLHelperPlaylistItems._();
  static final SQLHelperPlaylistItems _instance = SQLHelperPlaylistItems._();

  factory SQLHelperPlaylistItems() {
    return _instance;
  }

  Future<Database> get database async{
    return await init();
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, DB_LOCAL);

    // Only run this to start from fresh
    deleteDatabase(dbPath);

    Future<Database> database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    print('Opened DB: ' + dbPath);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $DB_TABLE_PLAYLIST_ITEMS(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      songName TEXT,
      author TEXT,
      genre TEXT)
    ''');

    print("Table created: " + DB_TABLE_PLAYLIST_ITEMS);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  static Future<void> insert(LocalPlaylistItems data) async {
    final Database db = await SQLHelperPlaylistItems().database;

    await db.insert(
      DB_TABLE_PLAYLIST_ITEMS,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(data.toString());
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> readTable() async {
    final Database db = await SQLHelperPlaylistItems().database;
    return db.query(DB_TABLE_PLAYLIST_ITEMS, orderBy: "id");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperPlaylistItems().database;
    return db.query(DB_TABLE_PLAYLIST_ITEMS,
        where: "id = ?",
        whereArgs: [id],
        limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String songName, String? author) async {
    final db = await SQLHelperPlaylistItems().database;

    final data = {
      'songName': songName,
      'author': author,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update(
        DB_TABLE_SONGS_LIB,
        data,
        where: "id = ?",
        whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperPlaylistItems().database;
    try {
      await db.delete(
          DB_TABLE_SONGS_LIB,
          where: "id = ?",
          whereArgs: [id]);
    } catch (err) {
      print("ERROR Deleting Database item: $err");
    }
  }
}

