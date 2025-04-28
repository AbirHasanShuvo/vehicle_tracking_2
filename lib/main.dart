import 'package:flutter/material.dart';
import 'package:vehicle_tracking/pages/map_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MapPage());
  }
}
