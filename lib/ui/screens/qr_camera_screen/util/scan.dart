import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

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
