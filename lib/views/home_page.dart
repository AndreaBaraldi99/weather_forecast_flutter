import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/weather.dart';
import 'package:weather_forecast/weather_forecast_lib/weatherforecastresult.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherForecastResult forecastResult = WeatherForecastResult.noParam();
  Weather weather = Weather();
  Geolocation geolocation = Geolocation();
  var isLoaded = false;
  int itemsNumber = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Position position = await geolocation.determinePosition();
    forecastResult =
        await weather.getForecast(position.latitude, position.longitude);
    if (forecastResult.daily?.time?.length != null) {
      itemsNumber = forecastResult.daily!.time!.length;
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast ☀️'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            padding: const EdgeInsets.all(10),
            itemCount: itemsNumber,
            itemBuilder: (context, index) {
              return day(forecastResult.daily?.temperature2mMax?[index],
                  forecastResult.daily?.temperature2mMin?[index],
                  date: forecastResult.daily!.time![index]);
            }),
      ),
    );
  }
}

Container day(double? maxTemp, double? minTemp, {String date = ""}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Column(
          children: [
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              maxTemp.toString(),
              style: TextStyle(color: Colors.red[700]),
            )
          ],
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              minTemp.toString(),
              style: TextStyle(color: Colors.blue[900]),
            )
          ],
        )
      ],
    ),
  );
}
