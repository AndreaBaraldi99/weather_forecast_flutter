import 'dart:convert';

import 'package:weather_forecast/weather_forecast_lib/connection_check/connection_check.dart';
import 'package:weather_forecast/weather_forecast_lib/database/db_connection.dart';
import 'package:weather_forecast/weather_forecast_lib/database/db_item.dart';
import '../API_Connection/api.dart';
import '../weather_API/weatherforecastresult.dart';

class Weather {
  late String _apiRootWeather;
  late String _forecastParams;
  late API _api;
  late DbConnection _database;
  late ConnectionCheck _connectionCheck;

  Weather() {
    _apiRootWeather = "https://api.open-meteo.com/v1/forecast?";
    _forecastParams =
        "daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,windspeed_10m_max&timezone=auto";
    _api = API();
    _database = DbConnection();
    _connectionCheck = ConnectionCheck();
  }

  Future<WeatherForecastResult> getForecast(
      double? latitude, double? longitude, String location) async {
    String url =
        "$_apiRootWeather$_forecastParams&latitude=$latitude&longitude=$longitude";
    var connectionStatus = await _connectionCheck.checkConnectivity();
    if (connectionStatus) {
      var weatherResponse = await _api.callAPI(url);
      if (weatherResponse.responseCode != 0) {
        var result = WeatherForecastResult.fromJson(
            jsonDecode(weatherResponse.responseBody));
        _database.insertData(WeatherResponse(
            dateTime: DateTime.now().toIso8601String(),
            data: weatherResponse.responseBody,
            location: location));
        result.emptyResponse = false;
        return result;
      }
    }
    var resultList = await _database.retrieveData();
    if (resultList.isNotEmpty) {
      var result =
          WeatherForecastResult.fromJson(jsonDecode(resultList.last.data));
      result.emptyResponse = false;
      return result;
    } else {
      return WeatherForecastResult();
    }
  }
}
