import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maiporarisu/data/location/location.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Location location = Location();

  String _locationview = "no data";

  Future<void> getLocation() async {
    BuildContext context = this.context;
    Position pos = await location.determinePosition(context);
    setState(() {
      _locationview =
          "TimeStamp: ${pos.timestamp}, Latitude: ${pos.latitude}, Longitude: ${pos.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _locationview,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getLocation, child: const Icon(Icons.location_on)),
    );
  }
}
