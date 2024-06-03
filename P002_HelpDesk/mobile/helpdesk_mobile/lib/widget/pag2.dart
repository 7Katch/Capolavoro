import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pag2 extends StatefulWidget {
  const Pag2({super.key});

  @override
  _Pag2State createState() => _Pag2State();
}

class _Pag2State extends State<Pag2> {
  bool dipendenteCercato = false;
  bool visualizzaErrore = false;
  String testo = "Premi il bottone";

  //Variabili del dipendente
  String nome = "";
  String reparto = "";
  String codice = "";

  String messaggioErrore = "";

  String fetch = "fetch";
  List<Widget> infoStanze = [const Text("prova")];

  TextEditingController testoDipendente = TextEditingController();
  TextEditingController testoServer =
      TextEditingController(text: "192.168.1.124");

  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  // String infoDipendente = "aaaaaa";
  String datiDipendente = "..."; // DATI DEL DIPENDENTE

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.orangeAccent;
    double height = pressed ? 150 : 250;
    double width = pressed ? 150 : 250;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'pagina 2',
            style: GoogleFonts.nunito(
              color: Colors.black,
            ),
          )),
          backgroundColor: const Color.fromARGB(255, 22, 79, 236),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: const Color.fromARGB(255, 6, 26, 43),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                      side: const BorderSide(
                          width: 4, color: Color.fromARGB(255, 4, 49, 197)),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: "RobotoMono",
                          color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context, "/");
                  },
                  child: const Text("Torna indietro"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: const Color.fromARGB(255, 6, 26, 43),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                      side: const BorderSide(
                          width: 4, color: Color.fromARGB(255, 4, 49, 197)),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: "RobotoMono",
                          color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      // infoStanze = [];
                      // infoStanze.add(const SizedBox(
                      //   width: 200,
                      //   height: 200,
                      //   child: Card(),
                      // ));
                    });
                  },
                  child: const Text("Aggiungi animazione"),
                ),
              ),
              ...infoStanze,
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      pressed = !pressed;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: width,
                      color: color,
                      height: height,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
