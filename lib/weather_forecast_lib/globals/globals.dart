library my_prj.globals;

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/database/db_connection.dart';
import 'package:weather_forecast/weather_forecast_lib/services/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/core/weather.dart';
import 'package:weather_forecast/weather_forecast_lib/weather_API/weatherforecastresult.dart';

ValueNotifier<WeatherForecastResult> forecastResultNotifier =
    ValueNotifier<WeatherForecastResult>(WeatherForecastResult());
ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
ValueNotifier<bool> isLoaded = ValueNotifier<bool>(false);

class DataSync {
  final Geolocation geolocation = Geolocation();
  WeatherForecastResult forecastResult = WeatherForecastResult();
  final Weather weather = Weather();
  final DbConnection _database = DbConnection();

  getInitialData() async {
    Position position = await geolocation.determinePosition();
    forecastResult =
        await weather.getForecast(position.latitude, position.longitude, "");
    forecastResultNotifier.value = forecastResult;
    isLoaded.value = true;
  }

  searchWeather(double latitude, double longitude, String location) async {
    if (latitude != 1000 && longitude != 1000) {
      forecastResult = await weather.getForecast(latitude, longitude, location);
      forecastResult.location = location;
      forecastResultNotifier.value = forecastResult;
      isLoaded.value = false;
    } else {
      var resultList = await _database.retrieveDataFromLocation(location);
      if (resultList.isEmpty) {
        forecastResultNotifier.value.emptyResponse = true;
      } else {
        var result =
            WeatherForecastResult.fromJson(jsonDecode(resultList.last.data));
        result.location = location;
        result.timeStamp = resultList.last.dateTime;
        forecastResultNotifier.value = result;
      }
    }
  }
}
