import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class WeatherWidgets extends StatefulWidget {
  const WeatherWidgets({super.key});

  @override
  State<WeatherWidgets> createState() => WeatherWidgetsState();
}

class WeatherWidgetsState extends State<WeatherWidgets> {
  List<String> nicePhrase = List.empty(growable: true);
  String weatherCode = "";
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

  getData() {
    setState(() {
      weatherCode = globals.forecastResultNotifier.value.daily!.weatherIcon[0];
    });
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
                  margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    "Current location", //test value
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
