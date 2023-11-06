import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/data/location/location.dart';
import 'package:maiporarisu/data/model/task_model/task_model.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Task>>(
              future: userRequest.getAllTasks(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                final taskList = snapshot.data ?? <Task>[];
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = taskList[index];
                    return TaskCard(task: task);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              height: 200,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _locationview == 'no data'
                  ? Icon(
                      Icons.location_off,
                      size: 80,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.25),
                    )
                  : Text(_locationview),
            ),
            const SizedBox(
              height: 300,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(35.681236, 139.767125), // デフォルト: 東京駅
                    zoom: 16.0,
                  ),
                  // その他のGoogleMapの設定
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getLocation,
        child: const Icon(Icons.location_on),
      ),
    );
  }
}

class TaskCard extends HookWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final done = useState(task.check);
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          done.value = !done.value;
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                done.value
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_outlined,
                color:
                    done.value ? Theme.of(context).colorScheme.primary : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(task.time),
                      ],
                    ),
                    Text(
                      task.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
