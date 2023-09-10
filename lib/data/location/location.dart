import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maiporarisu/ui/screens/location_alert/location_alert.dart';

class Location {
  Future<Position> determinePosition(BuildContext context) async {
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    LocationPermission permission;
    LocationAlert locationAlert = const LocationAlert();

    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      await showDialog(
        context: context,
        builder: (context) {
          return locationAlert;
        },
      );
      return Future.error('Location permissions are denied');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
