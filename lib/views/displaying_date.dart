import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/weather_forecast_lib/services/geolocator.dart';
import 'package:weather_forecast/weather_forecast_lib/core/weather.dart';
import 'package:weather_forecast/weather_forecast_lib/weather_API/weatherforecastresult.dart';
import '../weather_forecast_lib/globals/globals.dart' as globals;

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => DateWidgetState();
}

class DateWidgetState extends State<DateWidget> {
  final ScrollController _firstController = ScrollController();
  List<DateSelected> dateSelected = List.empty(growable: true);
  WeatherForecastResult forecastResult = WeatherForecastResult();
  Geolocation geolocation = Geolocation();
  Weather weather = Weather();
  int itemsNumber = 0;

  @override
  void initState() {
    super.initState();
    getData();
    globals.forecastResultNotifier.addListener(() {
      getData();
    });
  }

  onPressed(int index) {
    if (mounted) {
      setState(() {
        for (var value in dateSelected) {
          value.selected = false;
        }
        dateSelected[index].selected = true;
      });
      globals.selectedIndex.value = index;
    }
  }

  getData() async {
    forecastResult = globals.forecastResultNotifier.value;
    if (forecastResult.daily != null && forecastResult.daily!.time != null) {
      for (var element in forecastResult.daily!.time!) {
        if (element == forecastResult.daily!.time![0]) {
          dateSelected.add(DateSelected(element, true));
        } else {
          dateSelected.add(DateSelected(element, false));
        }
      }
    }
    setState(() {
      itemsNumber = forecastResult.daily!.time!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemsNumber,
      controller: _firstController,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemBuilder: ((context, index) {
        return day(
            dateSelected[index].date, dateSelected[index].selected, index);
      }),
    );
  }

  Container day(String date, bool selected, int index) {
    var dateValue = DateFormat("yyyy-MM-dd").parseUTC(date);
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: selectedBackgroundColor(selected),
            border: Border.all(
              color: (Colors.grey[400]!),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: TextButton(
            onPressed: (() {
              if (mounted) {
                onPressed(index);
              }
            }),
            child: Text(
              DateFormat("EEEE, d MMMM").format(dateValue),
              style:
                  TextStyle(color: selected ? Colors.black : Colors.grey[400]),
            )));
  }

  Color selectedBackgroundColor(bool selected) {
    if (selected) {
      return Colors.pink[200]!;
    } else {
      return Colors.transparent;
    }
  }
}

class DateSelected {
  String date;
  bool selected;

  DateSelected(this.date, this.selected);
}
