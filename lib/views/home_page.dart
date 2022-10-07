import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/weather.dart';
import 'package:weather_forecast/weather_forecast_lib/weatherforecastresult.dart';
import 'globals.dart' as globals;

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
  final ScrollController _firstController = ScrollController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    globals.notify.addListener(() {
      getData();
    });
    if (globals.notify.value.isEmpty == false) {
      forecastResult = await weather.getForecast(0, 0, globals.notify.value);
    } else {
      Position position = await geolocation.determinePosition();
      forecastResult =
          await weather.getForecast(position.latitude, position.longitude);
    }
    if (forecastResult.daily?.time?.length != null) {
      itemsNumber = forecastResult.daily!.time!.length;
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Visibility(
        visible: isLoaded,
        child: RawScrollbar(
          thumbColor: Colors.white54,
          crossAxisMargin: 5,
          thumbVisibility: true,
          controller: _firstController,
          radius: const Radius.circular(10),
          child: ListView.separated(
              controller: _firstController,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              padding: const EdgeInsets.all(15),
              itemCount: itemsNumber,
              itemBuilder: (context, index) {
                return day(
                    forecastResult.daily?.temperature2mMax?[index],
                    forecastResult.daily?.temperature2mMin?[index],
                    forecastResult.daily?.weatherIcon[index],
                    date: forecastResult.daily!.time![index]);
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    weather.closeDbConnection();
  }
}

Container day(double? maxTemp, double? minTemp, String? weatherIcon,
    {String date = ""}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.blue[100],
        border: Border.all(
          color: (Colors.white),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Column(
          children: [
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        const SizedBox(width: 12),
        Column(
          children: [
            Text(
              '${maxTemp.toString()}°',
              style: TextStyle(color: Colors.red[700]),
            )
          ],
        ),
        const SizedBox(width: 12),
        Column(
          children: [
            Text(
              '${minTemp.toString()}°',
              style: TextStyle(color: Colors.blue[900]),
            )
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Text(
              '$weatherIcon',
              style: const TextStyle(fontSize: 25),
            )
          ],
        )
      ],
    ),
  );
}
