// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:maiporarisu/ui/component/positioned_snack_bar.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/component/my_qr_code.dart';
import 'package:maiporarisu/ui/screens/qr_camera_screen/util/launch_url.dart';
import 'package:maiporarisu/ui/screens/setting_screen/setting_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCameraScreen extends ConsumerStatefulWidget {
  const QrCameraScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrCameraScreenState();
}

class _QrCameraScreenState extends ConsumerState<QrCameraScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _isScanned = false;
  final GlobalKey _globalKey = GlobalKey();
  var id = '';
  var openUrl = '';
  var _lastChangedDate = DateTime.now();
  final linkTime = 10;

  @override
  void initState() {
    super.initState();

    id = widget.id;
  }

  Future<String?> scanSelectedImage() async {
    try {
      final inputImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (inputImage == null) return null;
      final imageTemp = File(inputImage.path);
      return await scanCode(imageTemp.path);
    } on PlatformException catch (e) {
      Logger().e('Failed to pick image: $e');
      return null;
    }
  }

  Future<String> scanCode(String filePath) async {
    final InputImage inputImage = InputImage.fromFilePath(filePath);
    final barcodeScanner = BarcodeScanner();
    final barcodes = await barcodeScanner.processImage(inputImage);
    if (inputImage.metadata?.size == null ||
        inputImage.metadata?.rotation == null) {
      return barcodes.first.rawValue ?? '';
    }
    return '';
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

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
          Container(
            width: double.infinity,
            height: 320,
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
                        key: _globalKey,
                        child: MyQrCode(id: id),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < MediaQuery.of(context).size.height)
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.height * 0.4;
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
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
            width: (MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height)
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.height * 0.4,
            height: (MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height)
                ? MediaQuery.of(context).size.width * 0.4
                : MediaQuery.of(context).size.height * 0.4,
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
                    if (data != '') {
                      await _transitionToNextPage(data);
                      await _showScanData(data);
                    } else {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        PositionedSnackBar(
                          context,
                          'QRコードを読み取れませんでした',
                          bottom: 48,
                          foreground: Theme.of(context).colorScheme.onError,
                        ),
                      );
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
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
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
          if (str != '') {
            await _transitionToNextPage(str);
          } else if (openUrl != str ||
              nowDate.difference(_lastChangedDate).inSeconds >= linkTime) {
            openUrl = str;
            _lastChangedDate = nowDate;
            await _showScanData(openUrl);
          }
        }
      },
    );
    this.controller!.pauseCamera();
    this.controller!.resumeCamera();
  }

  Future<void> _showScanData(String data) async {
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
        duration: Duration(seconds: linkTime),
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

  Future<void> _transitionToNextPage(String data) async {
    if (!_isScanned) {
      await controller?.pauseCamera();
      _isScanned = true;
    }

    await Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ),
    )
        .then((value) {
      controller?.resumeCamera();
      _isScanned = false;
    });
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
