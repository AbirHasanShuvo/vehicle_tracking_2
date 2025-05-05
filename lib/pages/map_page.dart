import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  final Location _locationController = Location();
  static const LatLng _pGooglePlex = LatLng(
    37.422173551823825,
    -122.08534174259061,
  );
  static const LatLng _pApplePark = LatLng(
    37.42329807447437,
    -122.08734122486044,
  );
  LatLng? _currentP;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentP == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                onMapCreated:
                    ((GoogleMapController controller) =>
                        _mapController.complete(controller)),
                initialCameraPosition: CameraPosition(
                  target: _pGooglePlex,
                  zoom: 16.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('_sourceLocation'),
                    position: _pGooglePlex,
                    infoWindow: const InfoWindow(title: 'Googleplex'),
                  ),
                  Marker(
                    markerId: const MarkerId('_destinationLocation'),
                    position: _pApplePark,
                    infoWindow: const InfoWindow(title: 'Apple Park'),
                  ),
                  Marker(
                    markerId: const MarkerId('_currentLocation'),
                    position: _currentP!,
                    infoWindow: const InfoWindow(title: 'My_location'),
                  ),
                },
              ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: pos, zoom: 16.0);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
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
          _cameraToPosition(_currentP!);
        });
      }
    });
  }
}
