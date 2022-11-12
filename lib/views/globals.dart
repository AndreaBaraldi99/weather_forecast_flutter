library my_prj.globals;

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/weather.dart';
import 'package:weather_forecast/weather_forecast_lib/weatherforecastresult.dart';

ValueNotifier<WeatherForecastResult> forecastResultNotifier =
    ValueNotifier<WeatherForecastResult>(WeatherForecastResult.noParam());
ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
ValueNotifier<bool> isLoaded = ValueNotifier<bool>(false);

class DataSync {
  Geolocation geolocation = Geolocation();
  WeatherForecastResult forecastResult = WeatherForecastResult.noParam();
  Weather weather = Weather();

  getInitialData() async {
    Position position = await geolocation.determinePosition();
    forecastResult =
        await weather.getForecast(position.latitude, position.longitude);
    forecastResultNotifier.value = forecastResult;
    isLoaded.value = true;
  }
}
