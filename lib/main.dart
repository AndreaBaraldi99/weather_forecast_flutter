// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:weather_forecast/views/data_layer.dart';
import 'package:weather_forecast/views/displaying_date.dart';
import 'package:weather_forecast/weather_forecast_lib/globals/globals.dart';
import 'package:weather_forecast/views/location_and_phrase_widgets.dart';
import 'package:weather_forecast/views/menu_button.dart';
import 'package:weather_forecast/views/week_day.dart';
import 'package:weather_forecast/weather_forecast_lib/globals/globals.dart'
    as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isLoaded = false;
  ListView inizializedApp = ListView();

  @override
  void initState() {
    super.initState();
    globals.isLoaded.addListener(() {
      setState(() {
        inizializedApp = inizializeApp();
        isLoaded = true;
      });
    });
    DataSync data = DataSync();
    data.getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MainPage',
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromARGB(255, 24, 26, 38),
                    Color.fromARGB(255, 1, 0, 5),
                  ])),
              child: Center(
                child: isLoaded
                    ? inizializedApp
                    : const CircularProgressIndicator(),
              ))),
      debugShowCheckedModeBanner: false,
    );
  }

  ListView inizializeApp() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 70, child: WeatherWidgets()),
        const SizedBox(height: 70, child: WeekDayWidget()),
        Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: const DateWidget()),
        const DataWidget(),
        UnconstrainedBox(
          child: Container(
              width: 80,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 18, 26, 44),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              alignment: Alignment.center,
              child: const MenuButton()),
        )
      ],
    );
  }
}
