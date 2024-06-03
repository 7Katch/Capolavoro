import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/custom_widget/custom_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pag1 extends StatefulWidget {
  const Pag1({super.key});

  @override
  Pag1State createState() => Pag1State();
}

class Pag1State extends State<Pag1> {
  bool dipendenteCercato = false;
  bool visualizzaErrore = false;
  String testo = "Premi il bottone";

  //Variabili del dipendente
  String nome = "";
  String reparto = "";
  String codice = "";

  String messaggioErrore = "";

  String fetch = "fetch";
  List<Widget> infoStanze = [
    const Text("prova"),
  ];

  TextEditingController testoDipendente = TextEditingController();
  TextEditingController testoServer =
      TextEditingController(text: "192.168.1.124");

  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  // String infoDipendente = "aaaaaa";
  String datiDipendente = "..."; // DATI DEL DIPENDENTE

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomWidget.barraApplicazioni(title: "Pagina 1"),
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
                    Navigator.pushNamed(context, "/pag2");
                  },
                  child: const Text("Pagina 2"),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: TextField(
              //     controller: testoServer,
              //     decoration: const InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text("Inserisci indirizzo server")),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: TextField(
              //     controller: testoDipendente,
              //     decoration: const InputDecoration(
              //         border: OutlineInputBorder(),
              //         label: Text("Inserisci codice")),
              //   ),
              // ),
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
                      richiediDati();
                    });
                  },
                  child: const Text("Cerca il dipendente"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "DATI DEL DIPENDENTE CERCATO",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ...infoStanze
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> richiediDati() async {
    var response = await http.get(
        Uri.parse("http://192.168.1.124/P002_helpdesk/serverREST/dispositivi"));
    var risultato;

    //TODO ottenere dal database interno i dati della stanza

    if (response.statusCode == 200) {
      risultato = json.decode(response.body);

      setState(() {
        // Aggiungi gli elementi alla lista infoStanze
        infoStanze.clear();
        for (var el in risultato) {
          // print(el.runtimeType);
          infoStanze.add(SizedBox(
            width: 200,
            height: 200,
            child: Card(
              child: Column(
                children: [
                  Text(el["codice"].toString()),
                  Text(el["nome"].toString()),
                  Text(el["piano"].toString()),
                  Text(el["tipo"].toString()),
                ],
              ),
            ),
          ));
        }
      });
    }
  }
}
//leading: label == 'Nome' ? Icon(Icons.person) : label == 'Cognome' ? Icon(Icons.person) : label == 'Area' ? Icon(Icons.location_city) : Icon(Icons.badge),


