import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/data/location/location.dart';
import 'package:maiporarisu/data/task/task_model.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_drawer.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_schedule.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_search.dart';
import 'package:maiporarisu/ui/styles/size.dart';

class MapScheduleScreen extends StatefulWidget {
  const MapScheduleScreen({super.key});

  @override
  State<MapScheduleScreen> createState() => _MapScheduleScreenState();
}

class _MapScheduleScreenState extends State<MapScheduleScreen> {
  late GoogleMapController mapController;
  LatLng _currentPosition = const LatLng(35.681236, 139.767125);

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    Position pos = await Location().determinePosition(context);
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
    final userRequest = UserRequest(isMock: true);
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
          Container(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 16.0,
              ),
              myLocationEnabled: true,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            child: const MaiporarisuSearch(),
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
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
