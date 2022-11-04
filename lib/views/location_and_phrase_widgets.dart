import 'package:flutter/material.dart';

class WeatherWidgets extends StatefulWidget {
  const WeatherWidgets({super.key});

  @override
  State<WeatherWidgets> createState() => WeatherWidgetsState();
}

class WeatherWidgetsState extends State<WeatherWidgets> {
  List<String> nicePhrase = List.empty(growable: true);
  WeatherWidgetsState() {
    nicePhrase.add("Don't forget your umbrella today! 🌧️");
    nicePhrase.add("A nice day to go for a walk! ☀️");
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      //padding: const EdgeInsets.all(8.0),
      childAspectRatio: 2.9,
      //crossAxisSpacing: 10,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 8, 8),
              width: 150,
              child: _nicePhrase()),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 4),
          child: Container(
            height: 46,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                border: Border.all(
                  color: (Colors.white),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: Color.fromARGB(255, 232, 232, 232),
                ),
                Text(
                  "Milano", //test value
                  style: TextStyle(
                    color: Color.fromARGB(255, 232, 232, 232),
                  ),
                  //color: Color.fromARGB(255, 202, 208, 229)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text _nicePhrase() {
    var weatherCode = 0; //test value
    String chosenText;
    if (weatherCode == 0 || weatherCode == 1 || weatherCode == 2) {
      chosenText = nicePhrase[1];
    } else {
      chosenText = nicePhrase[0];
    }
    return Text(
      chosenText,
      style: const TextStyle(color: Color.fromARGB(255, 232, 232, 232)),
    );
  }
}
