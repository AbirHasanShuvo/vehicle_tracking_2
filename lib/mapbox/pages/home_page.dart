import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapboxMap? mapboxMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MapWidget(onMapCreated: _onMapCreated));
  }

  // void _onMapCreated(MapboxMap controller) {
  //   setState(() {
  //     mapboxMapController = controller;
  //   });

  //   mapboxMapController!.location.updateSettings(
  //     LocationComponentSettings(enabled: true, pulsingEnabled: true),
  //   );
  // }

  void _onMapCreated(MapboxMap controller) async {
    setState(() {
      mapboxMapController = controller;
    });

    var status = await Permission.location.request();
    if (status.isGranted) {
      mapboxMapController!.location.updateSettings(
        LocationComponentSettings(enabled: true, pulsingEnabled: true),
      );
    } else {
      // You can handle denied permission here
      debugPrint("Location permission not granted");
    }
  }

  Future<void> _setupPositionTracking() async {
    bool serviceEnabled;
    LocationPermission permission;
  }
}
