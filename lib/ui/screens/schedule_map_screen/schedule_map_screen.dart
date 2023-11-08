import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/data/location/location.dart';
import 'package:maiporarisu/data/task/task_model.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_drawer.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_schedule.dart';
import 'package:maiporarisu/ui/styles/size.dart';

class ScheduleMapScreen extends StatefulWidget {
  const ScheduleMapScreen({super.key});

  @override
  State<ScheduleMapScreen> createState() => _ScheduleMapScreenState();
}

class _ScheduleMapScreenState extends State<ScheduleMapScreen> {
  Location location = Location();

  String _locationview = 'no data';

  Future<void> getLocation() async {
    BuildContext context = this.context;
    Position pos = await location.determinePosition(context);
    setState(() {
      _locationview =
          'TimeStamp: ${pos.timestamp}, Latitude: ${pos.latitude}, Longitude: ${pos.longitude}';
    });
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
        ).withOpacity(0.75),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text('まいぽらりす'),
      ),
      drawer: const MaiporarisuDrawer(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(35.681236, 139.767125), // デフォルト: 東京駅
              zoom: 16.0,
            ),
            // その他のGoogleMapの設定
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
        onPressed: getLocation,
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
