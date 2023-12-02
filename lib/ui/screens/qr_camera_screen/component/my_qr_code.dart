import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrCode extends StatelessWidget {
  const MyQrCode({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 216,
      height: 216,
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCCCCCC), width: 3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          clipBehavior: Clip.hardEdge,
          child: QrImageView(
            data: id,
            version: QrVersions.auto,
            size: 200,
            eyeStyle: const QrEyeStyle(
              color: Color(0xFFCCCCCC),
              eyeShape: QrEyeShape.square,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              color: Color(0xFFCCCCCC),
              dataModuleShape: QrDataModuleShape.circle,
            ),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            errorCorrectionLevel: QrErrorCorrectLevel.M,
            padding: const EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }
}
