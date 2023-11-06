import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/data/location/location.dart';
import 'package:maiporarisu/data/model/task_model/task_model.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/component/task_item.dart';
import 'package:maiporarisu/ui/screens/schedule_map_screen/section/maiporarisu_drawer.dart';

class ScheduleMapScreen extends StatefulHookWidget {
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
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2,
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
          FutureBuilder<List<Task>>(
            future: userRequest.getAllTasks(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
              final taskList = snapshot.data ?? <Task>[];
              return ListView.builder(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + kToolbarHeight,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = taskList[index];
                  return TaskItem(task: task);
                },
              );
            },
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
