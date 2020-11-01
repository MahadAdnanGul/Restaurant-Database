import 'package:flutter/material.dart';
// change `flutter_database` to whatever your project name is
import 'package:newdb/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        RaisedButton(
        color:Colors.grey,
          child: Text('insert_customer', style: TextStyle(fontSize: 20),),
          onPressed: () {_insert1();},
        ),

        RaisedButton(
          color:Colors.green,
          child: Text('query_customer', style: TextStyle(fontSize: 20),),
        onPressed: () {_query1();},
      ),

      RaisedButton(
        color:Colors.blue,
        child: Text('update_customer', style: TextStyle(fontSize: 20),),
        onPressed: () {_update1();},
      ),
      RaisedButton(
        color:Colors.red[400],
        child: Text('delete_customer', style: TextStyle(fontSize: 20),),
        onPressed: () {_delete1();},
      ),
            RaisedButton(
              color:Colors.grey,
              child: Text('insert_order', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert2();},
            ),
            RaisedButton(
              color:Colors.green,
              child: Text('query_order', style: TextStyle(fontSize: 20),),
              onPressed: () {_query2();},
            ),
            RaisedButton(
              color:Colors.blue,
              child: Text('update_order', style: TextStyle(fontSize: 20),),
              onPressed: () {_update2();},
            ),
            RaisedButton(
              color:Colors.red[400],
              child: Text('delete_order', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete2();},
            ),
      ],
    ),
    ),
    );
  }

  // Button onPressed methods

  void _insert1() async {
    // row to insert
      final table_name='my_table';
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Mark',
      DatabaseHelper.columnAdd  : 20,
      DatabaseHelper.columnEmail  : 'Mark@gmail.com',
      DatabaseHelper.columnPass  : 'ZUCKED'
    };
    final id = await dbHelper.insert(row,table_name);
    print('inserted row id: $id');
  }
  void _insert2() async {
    // row to insert
    final table_name='my_order';
    Map<String, dynamic> row = {
      DatabaseHelper.columnPrice : 800,
      DatabaseHelper.columnStatus  : 'Ready',

    };
    final id = await dbHelper.insert(row,table_name);
    print('inserted row id: $id');
  }

  void _query1() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _query2() async {
    final allRows = await dbHelper.queryAllRows2();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update1() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mark',
      DatabaseHelper.columnAdd  : 28,
      DatabaseHelper.columnEmail  : 'Mark@gmail.com',
      DatabaseHelper.columnPass  : 'ZUCKED'
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
  void _update2() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId2   : 1,
      DatabaseHelper.columnPrice : 600,
      DatabaseHelper.columnStatus  : 'Ready'

    };
    final rowsAffected = await dbHelper.update2(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete1() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  void _delete2() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount2();
    final rowsDeleted = await dbHelper.delete2(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}

//NOTE FOR EACH TABLE ADD NEW BUTTONS FOR INSERT,DELETE,UPDATE and QUERY along with new functions for eg delete1 for customer table and delete2 for Border
//follow this format and make all the tables
//MAKE CORRESPONDING FUNCTIONS IN HELPER FILE