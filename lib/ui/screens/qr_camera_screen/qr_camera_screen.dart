import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/section/camera.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/section/qr.dart';

class QrCameraScreen extends StatelessWidget {
  const QrCameraScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          Qr(id: id),
          Camera(id: id),
        ],
      ),
    );
  }
}
