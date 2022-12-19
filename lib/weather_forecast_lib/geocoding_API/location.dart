import 'dart:convert';

import 'package:weather_forecast/weather_forecast_lib/API_Connection/api.dart';
import 'package:weather_forecast/weather_forecast_lib/connection_check/connection_check.dart';
import 'package:weather_forecast/weather_forecast_lib/geocoding_API/geolocation.dart';

class Location {
  final String _rootUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
  final String _locationUrl =
      ".json?types=place&access_token=pk.eyJ1IjoiYW5kcmVhOTlyIiwiYSI6ImNsYXdiODNzYzBlZ3QzcG1wejR6ZGVjaWIifQ.cxuEHMeg85zMNNwqfJbSlg";
  final String _coordUrl =
      ".json?limit=1&types=place&access_token=pk.eyJ1IjoiYW5kcmVhOTlyIiwiYSI6ImNsYXdiODNzYzBlZ3QzcG1wejR6ZGVjaWIifQ.cxuEHMeg85zMNNwqfJbSlg";
  final API _api = API();
  final ConnectionCheck _connectionCheck = ConnectionCheck();

  Future<Geocoding> getPlaceName(double? latitude, double? longitude) async {
    String url = "$_rootUrl$longitude,$latitude$_locationUrl";
    var connectionStatus = await _connectionCheck.checkConnectivity();
    if (connectionStatus) {
      var response = await _api.callAPI(url);
      if (response.responseCode != 0) {
        var result = Geocoding.fromJson(jsonDecode(response.responseBody));
        return result;
      }
    }
    return Geocoding();
  }

  Future<Geocoding> getCoord(String location) async {
    if (location.contains(" ")) {
      location.replaceAll(" ", "%20");
    }
    String url = "$_rootUrl$location$_coordUrl";
    var connectionStatus = await _connectionCheck.checkConnectivity();
    if (connectionStatus) {
      var response = await _api.callAPI(url);
      if (response.responseCode != 0) {
        var result = Geocoding.fromJson(jsonDecode(response.responseBody));
        return result;
      }
    }
    return Geocoding();
  }
}
