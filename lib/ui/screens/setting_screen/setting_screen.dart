import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/screens/qr_screen/qr_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text('Setting Screen'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QRViewExample(),
                  ),
                );
              },
              child: const Text('qrView'),
            ),
          ],
        ),
      ),
    );
  }
}
