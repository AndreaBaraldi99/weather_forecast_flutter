import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    Position position = await geolocation.determinePosition();
    setState(() {
      _kGooglePlex = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 13);
      markers.add(Marker(
          markerId: const MarkerId('id'),
          position: LatLng(position.latitude, position.longitude)));
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
      height: 200,
      width: 200,
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
