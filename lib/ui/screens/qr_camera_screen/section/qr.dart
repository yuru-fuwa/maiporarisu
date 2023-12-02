import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/component/my_qr_code.dart';

class Qr extends StatelessWidget {
  const Qr({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey();
    return Container(
      width: double.infinity,
      height: 240,
      color: Theme.of(context).colorScheme.onSecondary,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          children: [
            const SizedBox(
              width: 180,
              height: 216,
            ),
            Container(
              width: 180,
              height: 216,
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: FittedBox(
                child: RepaintBoundary(
                  key: globalKey,
                  child: MyQrCode(id: id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
