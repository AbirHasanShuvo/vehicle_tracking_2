import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  MapboxMap? mapboxMapController;



  void _onMapCreated(MapboxMap controller) {
    setState(() {
      mapboxMapController = controller;
    });

    mapboxMapController!.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MapWidget(onMapCreated: _onMapCreated));
  }
}
