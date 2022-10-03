import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api.dart';
import 'weatherforecastresult.dart';

class Weather {
  late String _apiRootWeather;
  late String _forecastParams;
  late String _apiRootLocation;
  late API _api;
  late WeatherForecastResult forecastResult;

  Weather() {
    _apiRootWeather = "https://api.open-meteo.com/v1/forecast?";
    _forecastParams =
        "daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,windspeed_10m_max&timezone=auto";
    _apiRootLocation =
        "http://api.positionstack.com/v1/forward?limit=1&access_key=d77ed0d76be5d6b096a219da1e7d8767";
    _api = API();
    forecastResult = WeatherForecastResult();
  }

  getForecast(double latitude, double longitude) async {
    String url =
        "$_apiRootWeather$_forecastParams&latitude=$latitude&longitude=$longitude";
    forecastResult =
        WeatherForecastResult.fromJson(jsonDecode(await _api.callAPI(url)));
  }
}
