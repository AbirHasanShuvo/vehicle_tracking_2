import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Page')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(23.785105488775283, 90.40087338411979),
          zoom: 16.0,
        ),
      ),
    );
  }
}
