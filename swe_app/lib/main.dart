import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  void foundBarCode(Barcode barcode, MobileScannerArguments? args) {
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint("Barcode found! $code");
      _screenOpened = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.all(3),
            child: Image.asset(
              "images/logo.png",
              height: 48,
              width: 48,
            ),
          ),
          centerTitle: true,
          title: Container(
            child: (Text(
              "S.W.C.S",
              style: GoogleFonts.notoSerif(
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          backgroundColor: const Color(0xFF0F172A),
        ),
        body: MobileScanner(
          // fit: BoxFit.contain,
          controller: cameraController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.torchState,
                      builder: (context, state, child) {
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(
                              Icons.flash_off_rounded,
                              size: 27,
                              color: Color(0xFF0F172A),
                            );
                          case TorchState.on:
                            return const Icon(
                              Icons.flash_on_rounded,
                              size: 27,
                              color: Color(0xFF0F172A),
                            );
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => cameraController.toggleTorch(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        print("clicked camera");
                      });
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 32,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.cameraFacingState,
                      builder: (context, state, child) {
                        switch (state as CameraFacing) {
                          case CameraFacing.front:
                            return const Icon(
                              Icons.camera_front_rounded,
                              size: 27,
                              color: Color(0xFF0F172A),
                            );
                          case CameraFacing.back:
                            return const Icon(
                              Icons.camera_rear_rounded,
                              size: 27,
                              color: Color(0xFF0F172A),
                            );
                        }
                      },
                    ),
                    iconSize: 32.0,
                    onPressed: () => cameraController.switchCamera(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
