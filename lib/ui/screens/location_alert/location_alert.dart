import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationAlert extends StatelessWidget {
  const LocationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('このアプリを使用するには位置情報取得許可が必要です。'),
      content: const Text('位置情報を利用します'),
      actions: <Widget>[
        OutlinedButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.pop(context),
        ),
        OutlinedButton(
          child: const Text('設定'),
          onPressed: () {
            openAppSettings();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
