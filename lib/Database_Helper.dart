import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  //1st table
  static final table = 'my_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAdd = 'address';
  static final columnEmail = 'email';
  static final columnPass = 'password';
  //end

  //2nd table
  static final table2 = 'my_order';

  static final columnId2 = 'order_id';
  static final columnPrice = 'price';
  static final columnStatus = 'status';



  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAdd INTEGER NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnPass  TEXT NOT NULL  
          )
          ''');

    await db.execute('''
         CREATE TABLE $table2 (
           $columnId2 INTEGER PRIMARY KEY,
           $columnPrice INTEGER NOT NULL,
           $columnStatus TEXT NOT NULL
          )
          ''');

  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  //UNIVERSAL INSERT
  Future<int> insert(Map<String, dynamic> row,final table_name) async {
    Database db = await instance.database;
    return await db.insert(table_name, row);
  }

  //The data present in the table is returned as a List of Map, where each
  // row is of type map
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
  Future<List<Map<String, dynamic>>> queryAllRows2() async {
    Database db = await instance.database;
    return await db.query(table2);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> queryRowCount2() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table2'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> update2(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId2];
    return await db.update(table2, row, where: '$columnId2 = ?', whereArgs: [id]);
  }


  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> delete2(int id) async {
    Database db = await instance.database;
    return await db.delete(table2, where: '$columnId2 = ?', whereArgs: [id]);
  }
}