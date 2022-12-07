import 'package:flutter/material.dart';
import 'package:weather_forecast/views/globals.dart';
import 'package:weather_forecast/weather_forecast_lib/geolocation.dart';
import 'package:weather_forecast/weather_forecast_lib/location.dart';
import 'package:weather_forecast/views/globals.dart' as globals;

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => MenuButtonState();
}

class MenuButtonState extends State<MenuButton> {
  final _formKey = GlobalKey<FormState>();
  String location = "";
  Geocoding geocoder = Geocoding();
  Location locator = Location();
  DataSync dataSync = DataSync();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Icon(Icons.search, color: Colors.grey[400]!),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return enterLocation();
            });
      },
    );
  }

  AlertDialog enterLocation() {
    return AlertDialog(
      content: Stack(children: [
        Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Enter location"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      searchData(value);
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Search"),
                ),
              ],
            )),
      ]),
    );
  }

  searchData(String location) async {
    var result = await locator.getCoord(location);
    dataSync.searchWeather(result.features!.first.center![1],
        result.features!.first.center![0], result.features!.first.text!);
  }
}
