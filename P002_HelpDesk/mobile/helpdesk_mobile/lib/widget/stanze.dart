import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/custom_widget/custom_widget.dart';

import 'package:helpdesk_mobile/database/dao/entities_dao.dart';
import 'package:helpdesk_mobile/database/database.dart';
import 'package:helpdesk_mobile/database/models/entities.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:developer';

class Stanze extends StatefulWidget {
  const Stanze({super.key});

  @override
  _StanzeState createState() => _StanzeState();
}

class _StanzeState extends State<Stanze> {
  bool dipendenteCercato = false;
  bool visualizzaErrore = false;
  late AppDatabase database;
  late Dao dao;

  String fetch = "fetch";
  List<Widget> infoStanze = [const Text("prova")];

  TextEditingController testoDipendente = TextEditingController();
  TextEditingController testoServer = TextEditingController(text: "LAP1");

  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  // String infoDipendente = "aaaaaa";

  bool pressed = false;

  @override
  Widget build(BuildContext buildContext) {
    connessioneDatabase();
    Color color = Colors.orangeAccent;
    double height = pressed ? 150 : 250;
    double width = pressed ? 150 : 250;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomWidget.barraApplicazioni(title: "Stanze"),
        drawer: const NavBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: PulsanteRoute(
                  route: "",
                  testo: "Torna indietro",
                  onPressed: () {
                    Navigator.pop(context, "/");
                  },
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
                    setState(() {});
                  },
                  child: const Text("     Cerca     "),
                ),
              ),
              FutureBuilder(
                  future: richiestaStanze(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      List info = snapshot.data!;

                      if (info.isEmpty) {
                        return Text(
                          "Non esistono dispositivi nella stanza cercata",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        );
                      }

                      List<Widget> widget = [];
                      inspect(info[0]);
                      for (var row in info) {
                        widget.add(SizedBox(
                          width: 150,
                          height: 150,
                          child: Card(
                            child: Column(
                              children: [
                                Text(row.nome.toString()),
                                Text(row.tipo.tipo),
                                // Text(row..toString()),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        buildContext, "/segnalazione");
                                  },
                                  child: const Text("Segnala"),
                                ),
                              ],
                            ),
                          ),
                        ));
                      }

                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: widget,
                      );
                    }
                  })),
              // Center(
              //   child: InkWell(
              //     onTap: () {
              //       setState(() {
              //         pressed = !pressed;
              //       });
              //     },
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(20),
              //       child: AnimatedContainer(
              //         duration: const Duration(milliseconds: 200),
              //         width: width,
              //         color: color,
              //         height: height,
              //       ),
              //     ),
              //   ),
              // ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> connessioneDatabase() async {
    database =
        await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
    dao = database.dao;
    print("creato database");
  }

  Future<List> richiestaStanze() async {
    //simulazione della richiesta GET
    await Future.delayed(const Duration(seconds: 1));
    List<Stanza> stanze = await dao.getStanze();
    return stanze;
  }
}

