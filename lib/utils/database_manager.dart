import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:team_player/utils/global_data.dart';


class SQLHelper {
  // Make it a Singleton Class
  SQLHelper._();
  static final SQLHelper _instance = SQLHelper._();

  factory SQLHelper() {
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
  Future<Database> get database async{
  return await init();
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, DB_LOCAL);
    //deleteDatabase(dbPath);
    Future<Database> database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    print('Opened DB: ' + dbPath);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $DB_LOCAL_SONGS_TABLE(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      songName TEXT,
      author TEXT,
      genre TEXT,
      dateModified TEXT,
      isActive INTEGER)
  ''');

    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<void> Insert(LocalSongsLibrary data) async {
    final Database db = await SQLHelper().database;

    await db.insert(
      DB_LOCAL_SONGS_TABLE,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(data.toString());
  }

// Read all items (journals)
 static Future<List<Map<String, dynamic>>> readTable(String table) async {
    final Database db = await SQLHelper().database;
    return db.query(table, orderBy: "id");
  }

// Read a single item by id
// The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper().database;
    return db.query(DB_LOCAL_SONGS_TABLE,
        where: "id = ?",
        whereArgs: [id],
        limit: 1);
  }

// Update an item by id
  static Future<int> updateItem(int id, String title, String? descrption) async {
    final db = await SQLHelper().database;

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update(
        DB_LOCAL_SONGS_TABLE,
        data,
        where: "id = ?",
        whereArgs: [id]);
    return result;
  }

// Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper().database;
    try {
      await db.delete(
          DB_LOCAL_SONGS_TABLE,
          where: "id = ?",
          whereArgs: [id]);
    } catch (err) {
      print("ERROR Deleting Database item: $err");
    }
  }

  void DB_Read() async {
    final Database db = await SQLHelper().database;
    List<Map> result = await db.rawQuery('SELECT * FROM $DB_LOCAL_SONGS_TABLE');

    // ar.fromDb(Map<String, dynamic> map)
    //     : id = map['id'],
    //       songname = map['songname'],
    //       author = map['author'],
    //       genre = map['genre'],
    //       //isElectro = map['is_electro'] == 1;
    //   dateModified = map['dateModified'];

  }
}

