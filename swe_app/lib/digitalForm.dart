import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyDigitalForm extends StatefulWidget {
  const MyDigitalForm({super.key});
  @override
  State<MyDigitalForm> createState() => _MyAppState();
}

class _MyAppState extends State<MyDigitalForm> {
  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('http://192.168.160.216:5173/mobilePage1'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: const Icon(
              Icons.menu_rounded,
              size: 32,
            ),
          ),
        ],
        backgroundColor: const Color(0xFF0F172A),
      ),
      body:WebViewWidget(
        controller: controller
      ),
    );
  }
}
