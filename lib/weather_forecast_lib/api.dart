import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_forecast/weather_forecast_lib/weatherforecastresult.dart';

class API {
  Future<WeatherForecastResult> callAPI(url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return WeatherForecastResult.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
