// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maiporarisu/ui/component/positioned_snack_bar.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/util/is_uuid.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/util/launch_url.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/util/scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Camera extends HookWidget {
  const Camera({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final qrKey = GlobalKey(debugLabel: 'QR');
    final controller = useState<QRViewController?>(null);
    var scanArea =
        (MediaQuery.of(context).size.width < MediaQuery.of(context).size.height)
            ? MediaQuery.of(context).size.width * 0.5
            : MediaQuery.of(context).size.height * 0.5;
    return Expanded(
      child: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: (controller) =>
                _onQRViewCreated(context, controller),
            overlay: QrScannerOverlayShape(
              borderColor: const Color(0xFFFFFFFF),
              borderRadius: 12,
              borderLength: 0,
              borderWidth: 0,
              cutOutSize: scanArea,
            ),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: scanArea,
              height: scanArea,
              decoration: BoxDecoration(
                color: const Color(0x22FFFFFF),
                border: Border.all(color: const Color(0x88FFFFFF), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              CupertinoIcons.qrcode,
              color: const Color(0x32FFFFFF),
              size: (MediaQuery.of(context).size.width <
                      MediaQuery.of(context).size.height)
                  ? MediaQuery.of(context).size.width * 0.2
                  : MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  child: IconButton(
                    onPressed: () async {
                      final String data = await scanSelectedImage() ?? '';
                      if (isUuid(data)) {
                        await _transitionToNextPage(
                          context,
                          data,
                          controller.value,
                        );
                      } else {
                        await _showScanData(context, data);
                      }
                    },
                    icon: const Icon(Icons.collections_rounded),
                    padding: const EdgeInsets.all(20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    const linkTime = 10;
    var openUrl = '';
    var lastChangedDate = DateTime.now();
    controller.resumeCamera();
    controller.scannedDataStream.listen(
      (scanData) async {
        log(scanData.code.toString());
        await HapticFeedback.vibrate();
        if (scanData.code == null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            PositionedSnackBar(
              context,
              'QRコードを読み取れませんでした',
              bottom: 48,
              foreground: Theme.of(context).colorScheme.onError,
            ),
          );
        } else if (describeEnum(scanData.format) == 'qrcode') {
          final str = scanData.code.toString();
          final nowDate = DateTime.now();
          if (isUuid(str)) {
            await _transitionToNextPage(context, str, controller);
          } else if (openUrl != str ||
              nowDate.difference(lastChangedDate).inSeconds >= linkTime) {
            openUrl = str;
            lastChangedDate = nowDate;
            await _showScanData(context, openUrl);
          }
        }
      },
    );
    controller.pauseCamera();
    controller.resumeCamera();
  }

  Future<void> _showScanData(BuildContext context, String data) async {
    const linkTime = 10;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 20,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        behavior: SnackBarBehavior.floating,
        clipBehavior: Clip.antiAlias,
        dismissDirection: DismissDirection.horizontal,
        margin: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 8,
        ),
        duration: const Duration(seconds: linkTime),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: await canLaunchUrl(Uri.parse(data.trim()))
                  ? const Icon(Icons.link_rounded)
                  : const Icon(Icons.link_off_rounded),
            ),
            Expanded(
              child: Text(
                data,
                style: const TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await Share.share(
                  data.trim(),
                  subject: 'QRコードの読み取り結果',
                );
              },
              icon: Icon(
                Icons.share_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: data.trim()),
                ).then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    PositionedSnackBar(
                      context,
                      'クリップボードにコピーしました',
                      icon: Icons.library_add_check_rounded,
                      bottom: 48,
                    ),
                  );
                });
              },
              icon: Icon(
                Icons.copy_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            await canLaunchUrl(Uri.parse(data.trim()))
                ? IconButton(
                    onPressed: () {
                      launchURL(data.trim(), context);
                    },
                    icon: Icon(
                      Icons.open_in_new_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.open_in_new_off_rounded,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.25),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _transitionToNextPage(
    BuildContext context,
    String data,
    QRViewController? controller,
  ) async {
    var isScanned = false;
    if (!isScanned) {
      await controller?.pauseCamera();
      isScanned = true;
    }

    // await Navigator.of(context)
    //     .push(
    //   MaterialPageRoute(
    //     builder: (context) => const SettingScreen(),
    //   ),
    // )
    Navigator.of(context).pop();
    await controller?.resumeCamera();
    isScanned = false;
    await _showScanData(context, data);
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        PositionedSnackBar(
          context,
          '権限がありません',
          icon: Icons.error_outline_rounded,
          foreground: Theme.of(context).colorScheme.onError,
        ),
      );
    }
  }
}
