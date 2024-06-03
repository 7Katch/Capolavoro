import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/custom_widget/custom_widget.dart';

import 'package:helpdesk_mobile/database/dao/entities_dao.dart';
import 'package:helpdesk_mobile/database/database.dart';
import 'package:helpdesk_mobile/database/models/entities.dart';
import 'package:helpdesk_mobile/providers/user_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:developer';

import 'package:provider/provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late BuildContext _context;
  AppDatabase? database;
  Dao? dao;

  List<Widget> infoStanze = [const Text("prova")];

  TextEditingController testoStanza = TextEditingController();

  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  String risposta_server = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    _context = buildContext;

    var notifier = ChangeNotifierProvider(create: (context) => UserProvider());

    return MultiProvider(
      providers: [
        notifier,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: CustomWidget.barraApplicazioni(title: "History"),
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

                FutureBuilder(
                    future: richiestaSegnalazioni(buildContext),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        List info = snapshot.data!;

                        // info.add(1);

                        if (info.isEmpty) {
                          return Text(
                            "Non ci sono ancora segnalazioni",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          );
                        }

                        // DataRow(
                        //     color: MaterialStatePropertyAll(Colors.orange),
                        //     cells: [
                        //       DataCell(Text("Dash")),
                        //       DataCell(Text("2018")),
                        //       DataCell(Text("2018")),
                        //       DataCell(Text(
                        //         "oieja289ebj2qb98e\nna89rh",
                        //         overflow: TextOverflow.fade,
                        //       )),
                        //       DataCell(
                        //         Row(
                        //           children: [
                        //             Icon(Icons.edit),
                        //             Icon(Icons.delete)
                        //           ],
                        //         ),
                        //       ),
                        //     ]),

                        List<DataRow> righeTabella = [];
                        for (Map<String, dynamic> row in info) {
                          righeTabella.add(DataRow(cells: [
                            DataCell(Text(row["id_utente"]
                                .substring(0, row["id_utente"].indexOf("@")))),
                            DataCell(Text(
                              row["data"].substring(0, 10),
                            )),
                            DataCell(Text(row["stato"],
                                style: GoogleFonts.poppins(
                                    color: row["stato"] == "non assegnato"
                                        ? Colors.red[400]
                                        : row["stato"] == "in corso"
                                            ? Colors.yellow[300]
                                            : Colors.green[400]))),
                            DataCell(Text(row["descrizione"])),
                            DataCell(
                              Row(
                                children: [
                                  const Icon(Icons.edit),
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  title: const Text(
                                                      "Cancellazione segnalazione"),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          String ipServer =
                                                              buildContext
                                                                  .read<
                                                                      UserProvider>()
                                                                  .ipServer;
                                                          var response =
                                                              await http.delete(
                                                                  Uri.parse(
                                                                      "http://$ipServer/P002_helpdesk/serverREST/segnalazione"),
                                                                  headers: {
                                                                    "Content-Type":
                                                                        "application/json"
                                                                  },
                                                                  body:
                                                                      jsonEncode({
                                                                    "id_utente": buildContext
                                                                        .read<
                                                                            UserProvider>()
                                                                        .userName,
                                                                    "data": row[
                                                                        "data"]
                                                                  }));

                                                          if (response
                                                                  .statusCode ==
                                                              200) {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Vuoi eliminare la segnalazione?")),
                                                  ]);
                                            });
                                      }),
                                ],
                              ),
                            ),
                          ]));
                        }

                        // return Column(
                        //   children: lista,
                        // );

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(columns: [
                            DataColumn(
                                label: Text("Utente",
                                    style: GoogleFonts.poppins(
                                        color: const Color.fromARGB(
                                            255, 15, 66, 107)))),
                            DataColumn(
                              label: Text("Data",
                                  style: GoogleFonts.poppins(
                                    color:
                                        const Color.fromARGB(255, 15, 66, 107),
                                  )),
                            ),
                            DataColumn(
                              label: Text("Stato",
                                  style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 15, 66, 107))),
                            ),
                            DataColumn(
                              label: Text("Descrizione",
                                  style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 15, 66, 107))),
                            ),
                            DataColumn(
                              label: Text("",
                                  style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                          255, 15, 66, 107))),
                            ),
                          ], rows: [
                            ...righeTabella,
                          ]),
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
      ),
    );
  }

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 206, 212, 212),
            shape: RoundedRectangleBorder(
              // side: const BorderSide(
              //     color: Color.fromARGB(255, 50, 122, 9), width: 10),
              borderRadius: BorderRadius.circular(30),
            ),
            title: SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Invio del form in corso",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const CircularProgressIndicator.adaptive()
                  ],
                ),
              ),
            ),
            actions: const [],
          );
        });
  }

  Future<List> richiestaSegnalazioni(BuildContext context) async {
    //simulazione della richiesta GET
    await Future.delayed(const Duration(seconds: 1));

    String url =
        "http://192.168.1.124/P002_helpdesk/serverREST/segnalazioni?d=${_context.read<UserProvider>().id_dispositivo}";
    try {
      var response = await http.get(Uri.parse(url));
      var risultato;
      if (response.statusCode == 200) {
        risultato = json.decode(response.body);
        risposta_server = response.body;
        return risultato;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
    return [];
  }
}
