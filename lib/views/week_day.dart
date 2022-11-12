import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/weather_forecast_lib/weatherforecastresult.dart';
import 'globals.dart' as globals;

class WeekDayWidget extends StatefulWidget {
  const WeekDayWidget({super.key});

  @override
  State<WeekDayWidget> createState() => WeekDayWidgetState();
}

class WeekDayWidgetState extends State<WeekDayWidget> {
  WeatherForecastResult forecastResult = WeatherForecastResult();
  int index = 0;
  String day = "";
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
    index = globals.selectedIndex.value;
    setState(() {
      if (index == 0) {
        day = "Today";
      } else if (index == 1) {
        day = "Tomorrow";
      } else {
        var dateValue = DateFormat("yyyy-MM-dd")
            .parseUTC(forecastResult.daily!.time![index]);
        day = DateFormat("EEEE, d MMMM").format(dateValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(8),
        child: Text(
          day,
          style: TextStyle(
              color: Colors.grey[200], fontFamily: 'Lato', fontSize: 25),
        ));
  }
}
