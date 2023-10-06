import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maiporarisu/data/controllers/user_request/user_request.dart';
import 'package:maiporarisu/data/location/location.dart';
import 'package:maiporarisu/data/model/task_model/task_model.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
    final userRequest = UserRequest();
    List<Task> taskList = <Task>[];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Task>>(
              future: userRequest.getAllTasks(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                taskList = snapshot.data ?? <Task>[];
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shadowColor: Colors.black,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Text('Time'),
                              Text(taskList[index].time),
                              const Text('Name:'),
                              Expanded(
                                child: Text(
                                  taskList[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Text(
              _locationview,
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
