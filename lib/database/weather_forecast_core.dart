import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_forecast/database/weather_forecast_dto.dart';

class WeatherRequestHandler {
  Database? database;

  WeatherRequestHandler() {
    syncDbConnection();
  }

  syncDbConnection() async {
    if (database == null || database!.isOpen == false) {
      database = await openConnection();
    } else {
      database!.close();
      database = await openConnection();
    }
  }

  Future<Database> openConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'weather_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE weather(id INTEGER PRIMARY KEY AUTOINCREMENT, date STRING, responseCode INTEGER, responseBody TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  // Define a function that inserts dogs into the database
  Future<void> insert(WeatherRequest weather) async {
    // Get a reference to the database.
    final db = database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db!.insert(
      'weather',
      weather.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WeatherRequest>> getAllRequests() async {
    // Get a reference to the database.
    final db = database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db!.query('weather');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return WeatherRequest(
          id: maps[i]['id'],
          date: maps[i]['date'],
          responseCode: maps[i]['responseCode'],
          responseBody: maps[i]['responseBody']);
    });
  }

  Future<void> update(WeatherRequest weatherRequest) async {
    // Get a reference to the database.
    final db = database;

    // Update the given Dog.
    await db!.update(
      'weather',
      weatherRequest.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [weatherRequest.id],
    );
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = database;

    // Remove the Dog from the database.
    await db!.delete(
      'weather',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  closeConnection() {
    if (database != null && database!.isOpen) {
      database!.close();
    }
  }
}
