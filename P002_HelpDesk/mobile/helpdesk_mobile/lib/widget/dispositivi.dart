import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/Animation/FadeAnimation.dart';
import 'package:helpdesk_mobile/custom_widget/custom_widget.dart';

import 'package:helpdesk_mobile/database/dao/entities_dao.dart';
import 'package:helpdesk_mobile/database/database.dart';
import 'package:helpdesk_mobile/database/models/entities.dart';
import 'package:helpdesk_mobile/providers/user_provider.dart';

// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'dart:developer';

import 'package:provider/provider.dart';

class Dispositivi extends StatefulWidget {
  const Dispositivi({super.key});

  @override
  _DispositiviState createState() => _DispositiviState();
}

class _DispositiviState extends State<Dispositivi> {
  late BuildContext _context;
  AppDatabase? database;
  Dao? dao;

  List<Widget> infoStanze = [const Text("prova")];

  TextEditingController testoStanza = TextEditingController();

  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  bool pressed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        testoStanza.text = _context.read<UserProvider>().stanza;
      });
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    _context = buildContext;
    Color color = Colors.orangeAccent;
    double height = pressed ? 150 : 250;
    double width = pressed ? 150 : 250;
    var notifier = ChangeNotifierProvider(create: (context) => UserProvider());

    return MultiProvider(
      providers: [
        notifier,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: CustomWidget.barraApplicazioni(title: "Dispositivi"),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: PulsanteRoute(
                    route: "",
                    testo: "        Cerca        ",
                    onPressed: () {
                      context
                          .read<UserProvider>()
                          .changeStanza(stanza: testoStanza.text);
                      setState(() {});
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: testoStanza,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Color.fromARGB(255, 122, 198, 248),
                        label: Text("Inserisci il nome della classe")),
                  ),
                ),
                FutureBuilder(
                    future: richiestaDispositivi(buildContext),
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
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          );
                        }

                        List<Widget> widget = [];

                        for (Dispositivo row in info) {
                          widget.add(GestureDetector(
                            onTap: () {
                              showBottomDialog(
                                  nomeDispositivo: row.nome,
                                  nomeStanza: testoStanza.text,
                                  idDispositivo: row.codice);
                            },
                            child: ListTile(
                              leading: const Icon(Icons.computer),
                              title: Text(row.nome.toString()),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.more_vert),
                                    onPressed: () {
                                      showBottomDialog(
                                          nomeDispositivo: row.nome,
                                          nomeStanza: testoStanza.text,
                                          idDispositivo: row.codice);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ));
                        }

                        // return Wrap(
                        //   spacing: 20,
                        //   runSpacing: 20,
                        //   children: widget,
                        // );

                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                              children: widget
                                  .map((e) => FadeXAnimation(
                                        delay: 0.5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: SizedBox(
                                            height: 100,
                                            child: Card(
                                              color: Colors.lightBlue.shade50,
                                              child: Center(
                                                child: e,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()),
                        );
                      }
                    })),
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

  Future<void> connessioneDatabase(BuildContext context) async {
    database = context.watch<UserProvider>().database;
    dao = database?.dao;
    print("creato database");
  }

  Future<List> richiestaDispositivi(BuildContext context) async {
    if (database == null) {
      connessioneDatabase(context);
    }
    String nomeStanza = testoStanza.text;

    //simulazione della richiesta GET
    await Future.delayed(const Duration(seconds: 1));

    //! Deprecato
    // String url =
    //     "http://192.168.1.124/P002_helpdesk/serverREST/dispositivi?stanza=$stanza";
    // try {
    //   var response = await http.get(Uri.parse(url));
    //   var risultato;
    //   if (response.statusCode == 200) {
    //     risultato = json.decode(response.body);
    //     print(risultato);
    //     return risultato;
    //   }
    // } catch (e) {
    //   print(e.toString());
    //   return [];
    // }
    // return [];

    List<Stanza> stanze = await dao!.getStanze();

    var codiceStanza = 0;

    for (int i = 0; i < stanze.length; i++) {
      if ((stanze[i].nome).toLowerCase().compareTo(nomeStanza.toLowerCase()) ==
          0) {
        codiceStanza = stanze[i].codice;
      }
    }
    var result = await dao!.getDispositiviByStanza(codiceStanza);
    // var result = await dao.getDispositivi();
    return result;
  }

  void showBottomDialog(
      {required String nomeDispositivo,
      required String nomeStanza,
      required int idDispositivo}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text("Visualizza la history"),
                    onTap: () {
                      _context
                          .read<UserProvider>()
                          .changeidDispositivo(id: idDispositivo);
                      Navigator.popAndPushNamed(context, "/history");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text("Segnala"),
                    onTap: () {
                      //impostare la rotta con la stanza e il dispositivo associato
                      context
                          .read<UserProvider>()
                          .changeDispositivo(dispositivo: nomeDispositivo);
                      context
                          .read<UserProvider>()
                          .changeStanza(stanza: nomeStanza);
                      Navigator.popAndPushNamed(context, "/segnalazione");
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
