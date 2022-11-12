import 'dart:convert';
import 'package:weather_forecast/weather_forecast_lib/data.dart';

import 'api.dart';
import 'weatherforecastresult.dart';

class Weather {
  late String _apiRootWeather;
  late String _forecastParams;
  late String _apiRootLocation;
  late API _api;

  Weather() {
    _apiRootWeather = "https://api.open-meteo.com/v1/forecast?";
    _forecastParams =
        "daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum,windspeed_10m_max&timezone=auto";
    _apiRootLocation =
        "http://api.positionstack.com/v1/forward?limit=1&access_key=d77ed0d76be5d6b096a219da1e7d8767";
    _api = API();
  }

  Future<WeatherForecastResult> getForecast(double? latitude, double? longitude,
      [String? location]) async {
    if (location != null) {
      String locationUrl = "$_apiRootLocation&query=$location";
      var response = await _api.callAPI(locationUrl);
      var locationResult = Data.fromJson(jsonDecode(response.responseBody));
      latitude = locationResult.data?.first.latitude;
      longitude = locationResult.data?.first.longitude;
    }
    String url =
        "$_apiRootWeather$_forecastParams&latitude=$latitude&longitude=$longitude";
    var weatherResponse = await _api.callAPI(url);
    var result = WeatherForecastResult.fromJson(
        jsonDecode(weatherResponse.responseBody));
    return result;
  }
}
