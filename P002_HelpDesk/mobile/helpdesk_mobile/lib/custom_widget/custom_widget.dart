import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PulsanteRoute extends StatelessWidget {
  final String route;
  final String testo;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;

  const PulsanteRoute(
      {super.key, required this.route, required this.testo, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 42, 149, 237),
            foregroundColor: const Color.fromARGB(255, 234, 238, 241),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
            // side: const BorderSide(
            //     width: 4, color: Color.fromARGB(255, 4, 49, 197)),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            textStyle: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
        onPressed: () {
          if (onPressed == null) {
            Navigator.pushNamed(context, route);
          } else {
            onPressed();
          }
        },
        child: Text(testo),
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  late String _scanBarcodeResult;

  TextEditingController ipServerController =
      TextEditingController(text: "192.168.1.124");

  late BuildContext _context;

  Future<void> scanQrNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      _scanBarcodeResult = barcodeScanRes;

      //LAP1-WS01
      List<String> components = _scanBarcodeResult.split("-");

      _context.read<UserProvider>().changeStanza(stanza: components[0]);

      if (components.length == 2) {
        _context.read<UserProvider>().changeDispositivo(
            dispositivo:
                _scanBarcodeResult.substring(0, _scanBarcodeResult.length - 1));
      } else {
        _context.read<UserProvider>().changeDispositivo(dispositivo: "");
      }

      _scanBarcodeResult =
          "Stanza: '${_context.read<UserProvider>().stanza}' Dispositivo : '${_context.read<UserProvider>().dispositivo}'";

      // _scanBarcodeResult = _context.read<UserProvider>().dispositivo;

      inspect(_scanBarcodeResult);
      Navigator.popAndPushNamed(_context, "/segnalazione");
    } on PlatformException {
      barcodeScanRes = "Failder to get platform version";
      print("nn funziona");
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                accountName: const Text("Davide Yeh",
                    style: TextStyle(
                        color: Colors.black)), // da prendere con il provider
                accountEmail: Text(context.read<UserProvider>().userName,
                    style: const TextStyle(
                        color: Colors.black)), // da prendere con il provider
                currentAccountPicture: const CircleAvatar(
                  child: ClipOval(
                    child: Image(
                      image: AssetImage("assets/icona_scuola.png"),
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue[900]!,
                      Colors.blue[800]!,
                      Colors.blue[400]!
                    ],
                  ),
                )),
            ListTile(
                leading: const Icon(Icons.home_filled),
                title: const Text("Home"),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/");
                }),
            ListTile(
                leading: const Icon(Icons.flag),
                title: const Text("Segnala"),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/segnalazione");
                }),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.warning),
                title: const Text("Alert"),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text("Scan"),
                onTap: () {
                  scanQrNormal();
                  // Navigator.pushNamed(context, "/scan");
                }),
            ListTile(
                leading: const Icon(Icons.email),
                title: const Text("Messaggi"),
                onTap: () {
                  Navigator.pushNamed(context, "/messaggi");
                },
                trailing: ClipOval(
                  child: Container(
                      color: Colors.red,
                      width: 20,
                      height: 20,
                      child: const Center(
                        child: Text("1",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      )),
                )),
            ListTile(
                leading: const Icon(Icons.group),
                title: const Text("Gestione utenti"),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Cambia ip server"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("cambio server"),
                          actions: [
                            TextField(controller: ipServerController),
                            ElevatedButton(
                                onPressed: () {
                                  String ipServer = ipServerController.text;
                                  context.read<UserProvider>().changeIpServer(newIpServer : ipServer);
                                },
                                child: Text("Cambia server")),
                          ],
                        );
                      });
                }),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () {
                  context.read<UserProvider>().changeUserName(newUsername: "");
                  context.read<UserProvider>().changePassword(password: "");

                  // Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.pushNamed(context, "/");
                }),
          ],
        ),
      ),
    );
  }
}

class CustomWidget {
  // CustomWidget();

  static AppBar barraApplicazioni({required String title}) {
    return AppBar(
      title: Center(
          child: Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.bold))),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.transparent, // Imposta lo sfondo trasparente
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[800]!, Colors.blue[600]!, Colors.blue[400]!],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }
}
