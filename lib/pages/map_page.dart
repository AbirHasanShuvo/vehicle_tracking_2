import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();
  static const LatLng _pGooglePlex = LatLng(
    23.778036640980943,
    90.40585156395386,
  );
  static const LatLng _pApplePark = LatLng(
    23.822669356565928,
    90.45480580828423,
  );
  LatLng? _currentP = null;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

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

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged.listen((
      LocationData currentlocation,
    ) {
      if (currentlocation.latitude != null &&
          currentlocation.longitude != null) {
        setState(() {
          _currentP = LatLng(
            currentlocation.latitude!,
            currentlocation.longitude!,
          );
          print(_currentP);
        });
      }
    });
  }
}
