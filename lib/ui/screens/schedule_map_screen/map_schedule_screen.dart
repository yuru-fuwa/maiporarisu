import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maiporarisu/data/location/location.dart';
import 'package:maiporarisu/data/model/task.dart';
import 'package:maiporarisu/data/service/user_request.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_drawer.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_schedule.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_search.dart';
import 'package:maiporarisu/ui/styles/size.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScheduleScreen extends StatefulWidget {
  const MapScheduleScreen({super.key});

  @override
  State<MapScheduleScreen> createState() => _MapScheduleScreenState();
}

class _MapScheduleScreenState extends State<MapScheduleScreen> {
  late GoogleMapController mapController;
  late List<LatLng> points;
  LatLng _currentPosition = const LatLng(35.681236, 139.767125);
  LatLng _destinationPosition = const LatLng(0, 0);
  Directions? _directions;
  PolylinePoints polylinePoints = PolylinePoints();
  DirectionRoute get shortestRoute => _directions!.shortestRoute;
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _setupApiKeys();
    setState(() {});
    getLocation();
    setRoute();
  }

  String getGoogleApiKey() {
    if (Platform.isAndroid) {
      return dotenv.env['GOOGLE_API_ANDROID']!;
    } else if (Platform.isIOS) {
      return dotenv.env['GOOGLE_API_IOS']!;
    } else {
      return dotenv.env['GOOGLE_API_WEB']!;
    }
  }

  Future<void> _setupApiKeys() async {
    GoogleMapsDirections.init(googleAPIKey: getGoogleApiKey());
    setState(() {});
  }

  Future<void> setRoute() async {
    List<Polyline> polylineCoordinates = [];
    Directions directions = await getDirections(
      _currentPosition.latitude,
      _currentPosition.longitude,
      _destinationPosition.latitude,
      _destinationPosition.longitude,
      language: 'ja',
    );
    _directions = directions;

    if (directions.routes.isNotEmpty) {
      List<PointLatLng> results = polylinePoints.decodePolyline(
        directions.routes.first.overviewPolyline.points,
      );
      if (results.isNotEmpty) {
        polylineCoordinates.add(
          Polyline(
            width: 5,
            polylineId: const PolylineId('最短経路'),
            color: Colors.teal,
            points: results
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
          ),
        );
      }
    }
    points = polylineCoordinates.expand((polyline) => polyline.points).toList();
    setState(() {
      polylines = {
        Polyline(
          width: 5,
          geodesic: true,
          polylineId: const PolylineId('最短経路'),
          color: Colors.teal,
          points: points,
        ),
      };
    });
  }

  Future<void> getLocation() async {
    if (!await Permission.location.isGranted) {
      var status = await Permission.location.request();
      if (status != PermissionStatus.granted) {
        throw Exception('Location permission not granted');
      }
    }

    Position pos = await Location.determinePosition();
    await _updatePosition(pos);
  }

  Future<void> _updatePosition(Position pos) async {
    setState(() {
      _currentPosition = LatLng(pos.latitude, pos.longitude);
    });
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 16.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userRequest = UserRequest(isMock: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;

    final DraggableScrollableController draggableScrollableController =
        DraggableScrollableController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.alphaBlend(
          Theme.of(context).colorScheme.primary.withOpacity(0.08),
          Theme.of(context).colorScheme.background,
        ).withOpacity(0.85),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('まいぽらりす'),
      ),
      drawer: const MaiporarisuDrawer(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 16.0,
            ),
            myLocationEnabled: true,
            polylines:
                _destinationPosition != const LatLng(0, 0) ? polylines : {},
            markers: _destinationPosition != const LatLng(0, 0)
                ? {
                    Marker(
                      markerId: const MarkerId('destinationLocation'),
                      position: _destinationPosition,
                      infoWindow: const InfoWindow(title: '目的地'),
                    ),
                  }
                : <Marker>{},
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 100),
            child: MaiporarisuSearch(
              destinationPosition: _destinationPosition,
              onDestinationPositionChanged: (position) {
                setState(() {
                  _destinationPosition = position;
                });
              },
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              controller: draggableScrollableController,
              initialChildSize: MaiporarisuSize.defaultSheetHeight(context),
              minChildSize: MaiporarisuSize.defaultSheetHeight(context),
              maxChildSize: 1 -
                  (topPadding + MaiporarisuSize.minMapHeight(context)) /
                      screenHeight,
              snap: true,
              builder: (context, scrollController) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(
                      Theme.of(context).colorScheme.primary.withOpacity(0.08),
                      Theme.of(context).colorScheme.background,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: FutureBuilder(
                      future: userRequest.getAllTasks(),
                      builder: (context, snapshot) {
                        final taskList = snapshot.data ?? <Task>[];
                        return MaiporarisuSchedule(
                          maxHeight: screenHeight -
                              (topPadding +
                                  MaiporarisuSize.minMapHeight(context)),
                          tasks: taskList,
                          draggableScrollableController:
                              draggableScrollableController,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.bottom,
            ),
            color: Colors.transparent,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getLocation();
          if (_destinationPosition != const LatLng(0, 0)) setRoute();
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
