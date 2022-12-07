import 'package:flutter/material.dart';
import 'package:weather_forecast/weather_forecast_lib/geolocation.dart';
import 'package:weather_forecast/weather_forecast_lib/location.dart';
import 'package:weather_forecast/weather_forecast_lib/weatherforecastresult.dart';
import '../weather_forecast_lib/api.dart';
import 'globals.dart' as globals;

class WeatherWidgets extends StatefulWidget {
  const WeatherWidgets({super.key});

  @override
  State<WeatherWidgets> createState() => WeatherWidgetsState();
}

class WeatherWidgetsState extends State<WeatherWidgets> {
  List<String> nicePhrase = List.empty(growable: true);
  String weatherCode = "";
  String location = "";
  WeatherForecastResult result = WeatherForecastResult();
  API api = API();
  String rootUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
  String seqUrl =
      ".json?types=place&access_token=pk.eyJ1IjoiYW5kcmVhOTlyIiwiYSI6ImNsYXdiODNzYzBlZ3QzcG1wejR6ZGVjaWIifQ.cxuEHMeg85zMNNwqfJbSlg";
  Location locator = Location();
  Geocoding geocoding = Geocoding();

  WeatherWidgetsState() {
    nicePhrase.add("Don't forget your umbrella today! 🌧️");
    nicePhrase.add("A nice day to go for a walk! ☀️");
    nicePhrase.add("Not a good day for sunbathing! 🌥️");
  }

  @override
  void initState() {
    super.initState();
    getData();
    globals.forecastResultNotifier.addListener(() {
      getData();
    });
  }

  getData() async {
    result = globals.forecastResultNotifier.value;
    if (location.isEmpty && result.location.isEmpty) {
      geocoding = await locator.getPlaceName(result.latitude, result.longitude);
      setState(() {
        location = geocoding.features!.first.text!;
        weatherCode = result.daily!.weatherIcon[0];
      });
    } else {
      setState(() {
        location = result.location;
        weatherCode = result.daily!.weatherIcon[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      //padding: const EdgeInsets.all(8.0),
      childAspectRatio: 2.8,
      //crossAxisSpacing: 10,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 8, 8),
              width: 150,
              child: _nicePhrase(weatherCode)),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 4),
          child: Container(
            height: 46,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(
                  color: (Colors.grey[400]!),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                  child: Icon(
                    Icons.location_on,
                    size: 20,
                    color: Colors.grey[200]!,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    location,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Colors.grey[200], fontFamily: 'Lato'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text _nicePhrase(String weatherCode) {
    String chosenText;
    if (weatherCode.contains("☀️") || weatherCode.contains("🌤️")) {
      chosenText = nicePhrase[1];
    } else if (weatherCode.contains("🌦️") ||
        weatherCode.contains("🌧️") ||
        weatherCode.contains("❄️") ||
        weatherCode.contains("🌩️")) {
      chosenText = nicePhrase[0];
    } else {
      chosenText = nicePhrase[2];
    }
    return Text(
      chosenText,
      style: TextStyle(color: Colors.grey[200], fontFamily: 'Lato'),
    );
  }
}
