import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maiporarisu/data/controllers/data_controller.dart';
import 'package:maiporarisu/data/location/location.dart';
import 'package:maiporarisu/ui/screens/schedule_screen/task_widget.dart';

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

  _loadData() async {
    await Get.find<DataController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(Get.find<DataController>().myData.length.toString());
    _loadData();
    List myData = [
      "Task1",
      "Task2",
    ];
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF2e3253).withOpacity(0.5),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
      alignment: Alignment.centerLeft,
    );
    final rightDeleteIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.redAccent,
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: GetBuilder<DataController>(builder: (controller) {
              return ListView.builder(
                itemCount: controller.myData.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: leftEditIcon,
                    secondaryBackground: rightDeleteIcon,
                    onDismissed: (DismissDirection directtion) {},
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.endToStart) {
                        return Future.delayed(const Duration(seconds: 1),
                            () => direction == DismissDirection.endToStart);
                      }
                    },
                    key: ObjectKey(index),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: TaskWidget(
                        text: controller.myData[index]["task_name"],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Text(
            _locationview,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getLocation, child: const Icon(Icons.location_on)),
    );
  }
}
