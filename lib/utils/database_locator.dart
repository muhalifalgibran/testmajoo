import 'package:flutter/material.dart';
import 'package:majootestcase/data/models/movie_response.dart';
import 'package:majootestcase/data/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocator {
  DatabaseLocator._constructor();
  static final DatabaseLocator instance = DatabaseLocator._constructor();

  static Database _database;
  Future<Database> get database async => _database ??= await initDb();

  DatabaseLocator();
  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'majoo.db');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE user (id INTEGER PRIMARY KEY, email Text, password Text, username TEXT)');
    });

    return database;
  }

  Future addUser(User user) async {
    Database database = await instance.database;
    return await database.insert('user', user.toJson());
  }

  Future<List<User>> getUser() async {
    Database database = await instance.database;
    var users = await database.query('user');

    List<User> userList =
        users.isNotEmpty ? users.map((e) => User.fromJson(e)).toList() : [];

    return userList;
  }
}
