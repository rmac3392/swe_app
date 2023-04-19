import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDigitalForm extends StatefulWidget {
  const MyDigitalForm({super.key});
  @override
  State<MyDigitalForm> createState() => _MyAppState();
}

class _MyAppState extends State<MyDigitalForm> {
  @override
  // TODO: implement widget
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
      body: Column(),
    );
  }
}
