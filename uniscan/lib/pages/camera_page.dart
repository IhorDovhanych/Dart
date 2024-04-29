import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uniscan/pages/home_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            if (image != null) {
              widget.pageController.animateToPage(0,
                  duration: const Duration(microseconds: 5000),
                  curve: Curves.linear);
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         title: Text(barcodes.first.rawValue ?? ''),
              //         content: Image(image: MemoryImage(image)),
              //       );
              //     });
            }
          }),
    );
  }
}
