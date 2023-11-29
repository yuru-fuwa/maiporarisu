import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  static Future<Position> determinePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      debugPrint(
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
      );
      return position;
    } catch (e) {
      debugPrint('Error getting location: $e');
      return Future.error(e);
    }
  }
}
