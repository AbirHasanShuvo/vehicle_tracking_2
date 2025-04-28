import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglePlex = LatLng(
    23.778036640980943,
    90.40585156395386,
  );
  static const LatLng _pApplePark = LatLng(
    23.822669356565928,
    90.45480580828423,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 12.0),
        markers: {
          Marker(
            markerId: const MarkerId('_currentLocation'),
            position: _pGooglePlex,
            infoWindow: const InfoWindow(title: 'Googleplex'),
          ),
          Marker(
            markerId: const MarkerId('_sourceLocation'),
            position: _pApplePark,
            infoWindow: const InfoWindow(title: 'Apple Park'),
          ),
        },
      ),
    );
  }
}
