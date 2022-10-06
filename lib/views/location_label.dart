import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:weather_forecast/extensions/string_extensions.dart';

class LocationLabel extends StatefulWidget {
  const LocationLabel({Key? key}) : super(key: key);

  @override
  _LocationLabelState createState() => _LocationLabelState();
}

class _LocationLabelState extends State<LocationLabel> {
  String location = "";

  stringCreate() {
    globals.notify.addListener(() {
      stringCreate();
    });
    setState(() {
      if (globals.notify.value.isEmpty == true) {
        location = "Current location";
      } else {
        location = globals.notify.value;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    stringCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text('Displaying weather for: ${location.capitalize()}'),
    );
  }
}
