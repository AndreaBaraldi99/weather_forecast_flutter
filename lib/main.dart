// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:weather_forecast/views/displaying_date.dart';
import 'package:weather_forecast/views/form.dart';
import 'package:weather_forecast/views/home_page.dart';
import 'package:weather_forecast/views/location_and_phrase_widgets.dart';
import 'package:weather_forecast/views/location_label.dart';
import 'package:weather_forecast/views/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
                Color.fromARGB(255, 34, 37, 54),
                Color.fromARGB(255, 1, 0, 5),
              ])),
          //height: 500,
          padding: const EdgeInsets.all(8),
          child: Center(
              child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              SizedBox(height: 100, child: WeatherWidgets()),
              SizedBox(height: 50, child: DateWidget()),
            ],
          )),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}



/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prova',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Weather Forecast ☀️')),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  (Colors.blue[600])!,
                  (Colors.lightBlue[400])!,
                ])),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                MyCustomForm(),
                LocationLabel(),
                HomePage(),
                MapSample()
              ],
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
*/