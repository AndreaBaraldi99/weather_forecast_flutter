import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_forecast/weather_forecast_lib/database/db_item.dart';

class DbConnection {
  Database? database;

  DbConnection() {
    setConnection();
  }

  setConnection() async {
    /* if (database != null && database!.isOpen) {
      database!.close();
    } */
    database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'weather_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE weather(id INTEGER PRIMARY KEY AUTOINCREMENT, dateTime TEXT, data TEXT, location TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertData(WeatherResponse weatherResponse) async {
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await database!.insert(
      'weather',
      weatherResponse.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteData(String timestamp) async {
    // Remove the Dog from the database.
    await database!.delete(
      'weather',
      // Use a `where` clause to delete a specific dog.
      where: 'dateTime= ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [timestamp],
    );
  }

  Future<List<WeatherResponse>> retrieveData() async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await database!.query('weather');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return WeatherResponse(
          id: maps[i]['id'],
          dateTime: maps[i]['dateTime'],
          data: maps[i]['data'],
          location: maps[i]['location']);
    });
  }

  Future<List<WeatherResponse>> retrieveDataFromLocation(
      String location) async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await database!
        .query('weather', where: 'location= ?', whereArgs: [location]);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return WeatherResponse(
          id: maps[i]['id'],
          dateTime: maps[i]['dateTime'],
          data: maps[i]['data'],
          location: maps[i]['location']);
    });
  }
}
