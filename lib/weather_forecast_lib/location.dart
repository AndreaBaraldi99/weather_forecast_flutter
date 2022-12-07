import 'dart:convert';

import 'package:weather_forecast/weather_forecast_lib/api.dart';
import 'package:weather_forecast/weather_forecast_lib/geolocation.dart';

class Location {
  final String _rootUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
  final String _locationUrl =
      ".json?types=place&access_token=pk.eyJ1IjoiYW5kcmVhOTlyIiwiYSI6ImNsYXdiODNzYzBlZ3QzcG1wejR6ZGVjaWIifQ.cxuEHMeg85zMNNwqfJbSlg";
  final String _coordUrl =
      ".json?limit=1&types=place&access_token=pk.eyJ1IjoiYW5kcmVhOTlyIiwiYSI6ImNsYXdiODNzYzBlZ3QzcG1wejR6ZGVjaWIifQ.cxuEHMeg85zMNNwqfJbSlg";
  final API _api = API();

  Future<Geocoding> getPlaceName(double? latitude, double? longitude) async {
    String url = "$_rootUrl$longitude,$latitude$_locationUrl";
    var response = await _api.callAPI(url);
    var result = Geocoding.fromJson(jsonDecode(response.responseBody));
    return result;
  }

  Future<Geocoding> getCoord(String location) async {
    if (location.contains(" ")) {
      location.replaceAll(" ", "%20");
    }
    String url = "$_rootUrl$location$_coordUrl";
    var response = await _api.callAPI(url);
    var result = Geocoding.fromJson(jsonDecode(response.responseBody));
    return result;
  }
}
