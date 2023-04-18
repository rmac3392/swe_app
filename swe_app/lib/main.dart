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
              height: 50,
              width: 50,
            ),
          ),
          title: (Text(
              "S.W.C.S",
              style: GoogleFonts.notoSerif(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                textStyle: const TextStyle(fontStyle: FontStyle.italic),
              ),
            )),
          actions: [
            Container(
              margin: const EdgeInsets.all(5),
            child: const  Icon(
              Icons.menu_rounded,
              size: 32,
              ),
            ),
          ],
          backgroundColor: const Color(0xFF0F172A),
        ),
        body: MobileScanner(
          controller: cameraController,
          fit: BoxFit.fitWidth,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
            }
          },
        ),
        bottomNavigationBar: BottomAppBar( color: const Color(0xFF0F172A),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.torchState,
                      builder: (context, state, child) {
                        switch (state as TorchState) {
                          case TorchState.off:
                            return const Icon(
                              Icons.toggle_off_rounded,
                              size: 50,
                              color: Color(0xFFFEFEFE),
                            );
                          case TorchState.on:
                            return const Icon(
                              Icons.toggle_on_rounded,
                              size: 50,
                              color: Color(0xFFFEFEFE),
                            );
                        }
                      },
                    ),
                    iconSize: 42.0,
                    onPressed: () => cameraController.toggleTorch(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        print("clicked camera");
                      });
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 100,
                      color: Color(0xFFFEFEFE),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150,
                  child: IconButton(
                    icon: ValueListenableBuilder(
                      valueListenable: cameraController.cameraFacingState,
                      builder: (context, state, child) {
                        switch (state as CameraFacing) {
                          case CameraFacing.front:
                            return const Icon(
                              Icons.cameraswitch_rounded,
                              size: 47,
                              color: Color(0xFFFEFEFE),
                            );
                          case CameraFacing.back:
                            return const Icon(
                              Icons.cameraswitch_rounded,
                              size: 47,
                              color: Color(0xFFFEFEFE),
                            );
                        }
                      },
                    ),
                    iconSize: 42.0,
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