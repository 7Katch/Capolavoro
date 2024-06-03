import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/custom_widget/custom_widget.dart';
import 'package:helpdesk_mobile/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  ScanState createState() => ScanState();
}

class ScanState extends State<Scan> {
  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  String _scanBarcodeResult = "";
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      debugPrint(barcodeScanRes);
      setState(() {
        _scanBarcodeResult = barcodeScanRes;
      });
    } on PlatformException {
      barcodeScanRes = "Failder to get platform version";
      print("nn funziona");
    }
  }

  Future<void> scanQrNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      setState(() {
        _scanBarcodeResult = barcodeScanRes;

        //LAP1-WS01
        List<String> components = _scanBarcodeResult.split("-");

        _context.read<UserProvider>().changeStanza(stanza: components[0]);

        if (components.length == 2) {
          _context.read<UserProvider>().changeDispositivo(
              dispositivo:
                  components[1].substring(0, components[1].length - 1));
        } else {
          _context.read<UserProvider>().changeDispositivo(dispositivo: "");
        }

        _scanBarcodeResult =
            "Stanza: ${_context.read<UserProvider>().stanza} Dispositivo : ${_context.read<UserProvider>().dispositivo}";

        // _scanBarcodeResult = _context.read<UserProvider>().dispositivo;

        Navigator.popAndPushNamed(_context, "/segnalazione");
      });
    } on PlatformException {
      barcodeScanRes = "Failder to get platform version";
      print("nn funziona");
    }
  }

  late BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: const NavBar(),
          appBar: CustomWidget.barraApplicazioni(title: "Scan"),
          body: Center(
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: scanBarcodeNormal,
                    child: const Text("start barcode scan"),
                  ),
                  ElevatedButton(
                    onPressed: scanQrNormal,
                    child: const Text("start QR scan"),
                  ),
                  Text(_scanBarcodeResult),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//leading: label == 'Nome' ? Icon(Icons.person) : label == 'Cognome' ? Icon(Icons.person) : label == 'Area' ? Icon(Icons.location_city) : Icon(Icons.badge),
