import 'package:flutter/material.dart';
import 'package:weather_forecast/weather_forecast_lib/weather_API/weatherforecastresult.dart';
import '../weather_forecast_lib/globals/globals.dart' as globals;

class DataWidget extends StatefulWidget {
  const DataWidget({super.key});

  @override
  State<DataWidget> createState() => DataWidgetState();
}

class DataWidgetState extends State<DataWidget> {
  WeatherForecastResult forecastResult = WeatherForecastResult();
  var image;
  String maxTemp = "";
  String minTemp = "";
  String windSpeed = "";
  String precipitationSum = "";
  String sunrise = "";

  @override
  void initState() {
    super.initState();
    getData();
    globals.forecastResultNotifier.addListener(() {
      getData();
    });
    globals.selectedIndex.addListener(() {
      resetData();
    });
  }

  getData() {
    forecastResult = globals.forecastResultNotifier.value;
    resetData();
  }

  resetData() {
    var index = globals.selectedIndex.value;
    setState(() {
      setImage(forecastResult.daily!.weatherIcon[index]);
      setMaxTemp(forecastResult.daily!.temperature2mMax![index]);
      setMinTemp(forecastResult.daily!.temperature2mMin![index]);
      setWindSpeed(forecastResult.daily!.windspeed10mMax![index]);
      setPrecipitation(forecastResult.daily!.precipitationSum![index]);
      setSunrise(forecastResult.daily!.sunrise![index]);
    });
  }

  setImage(String weathercode) {
    switch (weathercode) {
      case "☀️":
        image = Image.asset('resources/images/sun.png');
        break;
      case "🌤️":
        image = Image.asset("resources/images/cloudy-day.png");
        break;
      case "☁️":
        image = Image.asset("resources/images/cloud.png");
        break;
      case "🌫️":
        image = Image.asset("resources/images/haze.png");
        break;
      case "🌦️":
      case "🌧️":
        image = Image.asset("resources/images/heavy-rain.png");
        break;
      case "❄️":
        image = Image.asset("resources/images/snowy.png");
        break;
      case "🌩️":
        image = Image.asset("resources/images/storm.png");
        break;
      default:
        image = Image.asset("resources/images/placeholder-image.png");
        break;
    }
  }

  setMaxTemp(double maxTemp) {
    int roundedTemp = maxTemp.toInt();
    this.maxTemp = "$roundedTemp°";
  }

  setMinTemp(double minTemp) {
    int roundedTemp = minTemp.toInt();
    this.minTemp = "$roundedTemp°";
  }

  setWindSpeed(double windSpeed) {
    this.windSpeed = "$windSpeed km/h";
  }

  setPrecipitation(double precipitationSum) {
    this.precipitationSum = "${precipitationSum.toString()} mm";
  }

  setSunrise(String sunrise) {
    this.sunrise = sunrise.substring(sunrise.indexOf("T") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 40, 8, 20),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 18, 26, 44),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            GridView.count(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  alignment: Alignment.topCenter,
                  child: image,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  alignment: Alignment.center,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          maxTemp,
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 42,
                              fontFamily: 'Lato'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          minTemp,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 42,
                              fontFamily: 'Lato'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 110,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 24, 34, 58),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      margin: const EdgeInsets.fromLTRB(14, 8, 0, 13),
                      child: infoBox(Icons.air, "Wind", windSpeed)),
                  Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 24, 34, 58),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      margin: const EdgeInsets.fromLTRB(18, 8, 18, 13),
                      child: infoBox(
                          Icons.umbrella, "Precipitation", precipitationSum)),
                  Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 24, 34, 58),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      margin: const EdgeInsets.fromLTRB(0, 8, 14, 13),
                      child: infoBox(Icons.wb_twilight, "Sunrise", sunrise))
                ],
              ),
            )
          ]),
    );
  }

  Column infoBox(IconData icon, String title, String data) {
    return Column(
      children: [
        Row(children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 35, 56, 232),
          )
        ]),
        Row(
          children: [
            Text(title,
                style: TextStyle(
                    fontFamily: 'Lato', color: Colors.grey[400], fontSize: 15)),
          ],
        ),
        Row(
          children: [
            Text(
              data,
              style: TextStyle(
                  fontFamily: 'Lato', color: Colors.grey[200], fontSize: 15),
            ),
          ],
        )
      ],
    );
  }
}
