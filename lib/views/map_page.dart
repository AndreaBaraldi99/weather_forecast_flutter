import 'dart:async';
import 'package:weather_forecast/weather_forecast_lib/weather.dart';

import 'globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_forecast/weather_forecast_lib/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  Geolocation geolocation = Geolocation();
  CameraPosition _kGooglePlex = const CameraPosition(target: LatLng(0, 0));
  var isLoaded = false;
  Set<Marker> markers = {};
  Weather weather = Weather();
  double latitude = 0;
  double longitude = 0;
  var changed = false;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    globals.notify.addListener(() {
      getLocation();
    });
    if (globals.notify.value.isEmpty == false) {
      var forecastResult =
          await weather.getForecast(0, 0, globals.notify.value);
      latitude = forecastResult.latitude!;
      longitude = forecastResult.longitude!;
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 13)));
    } else {
      Position position = await geolocation.determinePosition();
      latitude = position.latitude;
      longitude = position.longitude;
      _kGooglePlex =
          CameraPosition(target: LatLng(latitude, longitude), zoom: 13);
    }
    //_kGooglePlex = CameraPosition(target: LatLng(latitude, longitude), zoom: 13);
    setState(() {
      markers.add(Marker(
          markerId: const MarkerId('id'),
          position: LatLng(latitude, longitude)));
      isLoaded = true;
    });
  }

/*
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 250,
      child: Visibility(
        visible: isLoaded,
        child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers),
      ),
    );
  }
}
