import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:helpdesk_mobile/database/dao/entities_dao.dart';
import 'package:helpdesk_mobile/database/database.dart';

import 'package:helpdesk_mobile/database/models/entities.dart';
import 'package:helpdesk_mobile/providers/user_provider.dart';
import 'package:helpdesk_mobile/widget/stanze.dart';
import 'package:provider/provider.dart';
import '../custom_widget/custom_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Segnalazione extends StatefulWidget {
  const Segnalazione({super.key});

  @override
  _SegnalazioneState createState() => _SegnalazioneState();
}

class _SegnalazioneState extends State<Segnalazione> {
  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  bool isDeviceVisible = true;
  bool datiOttenuti = false;

  final _formKey = GlobalKey<FormBuilderState>();

  late http.Client httpClient;

  late BuildContext _context;

  late AppDatabase database;
  late Dao dao;

  List<Stanza> stanze = [];
  List<Dispositivo> dispositivi = [];

  List<String> nomiStanze = [
    "prova1",
    "prova2",
    "prova3",
  ];

  List<String> nomiDispositiviFiltrati = [
    "WS01",
    "WS02",
    "WS03",
  ];

  String rispostaServer = "";

  String stanzaSelezionata = "";
  String dispositivoSelezionato = "";

  bool opzioneDispositivo = true;
  String opzioneCategoria = "Tecnico";

  @override
  void initState() {
    super.initState();
    datiOttenuti = false;
    $FloorAppDatabase
        .databaseBuilder('flutter_database.db')
        .build()
        .then((value) {
      database = value;
      dao = database.dao;
      ottieniNomeStanze().then((value) {
        nomiStanze = value;
        setState(() {
          datiOttenuti = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    _context = buildContext;

    stanzaSelezionata = _context.read<UserProvider>().stanza;
    dispositivoSelezionato = _context.read<UserProvider>().dispositivo;

    ottieniDispositivi();

    if (datiOttenuti) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (buildContext) => UserProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/stanze": (buildContext) => const Stanze(),
          },
          home: Scaffold(
            drawer: const NavBar(),
            appBar: CustomWidget.barraApplicazioni(title: "Segnalazione"),
            body: SingleChildScrollView(
              child: Center(
                child: Column(children: [
                  Text(buildContext.watch<UserProvider>().stanza),
                  Text(buildContext.watch<UserProvider>().dispositivo),
                  PulsanteRoute(
                    route: "",
                    testo: "Torna indietro",
                    onPressed: () {
                      Navigator.pop(buildContext, "/");
                    },
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderRadioGroup(
                          decoration: const InputDecoration(
                              labelText: "Tipo di segnalazione"),
                          name: "tipo",
                          options: [
                            "Dispositivo",
                            "Stanza",
                          ]
                              .map((tipo) => FormBuilderFieldOption(
                                    value: tipo,
                                  ))
                              .toList(growable: false),
                          initialValue: "Dispositivo",
                          onChanged: (newValue) {
                            isDeviceVisible = newValue == "Dispositivo";
                            opzioneDispositivo = isDeviceVisible;
                            if (isDeviceVisible) {
                              opzioneCategoria = "Tecnico";
                            }
                            setState(() {});
                          },
                        ),
                        Visibility(
                          visible:
                              !opzioneDispositivo, // true se l'opzione NON e' Dispositivo
                          child: FormBuilderRadioGroup(
                            decoration:
                                const InputDecoration(labelText: "Categoria"),
                            name: "categoria",
                            options: [
                              "Tecnico",
                              "Strutturale",
                            ]
                                .map((tipo) => FormBuilderFieldOption(
                                      value: tipo,
                                    ))
                                .toList(growable: false),
                            initialValue: opzioneCategoria,
                            onChanged: (newValue) {},
                          ),
                        ),
                        FormBuilderDropdown<String>(
                          name: 'stanza',
                          validator: FormBuilderValidators.required(
                              errorText: 'Seleziona la stanza'),
                          initialValue: stanzaSelezionata,
                          decoration: InputDecoration(
                            labelText: 'Stanza',
                            suffix: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _formKey.currentState!.fields['stanza']
                                    ?.reset();
                              },
                            ),
                            hintText: 'Seleziona la classe',
                          ),
                          items: nomiStanze
                              .map((classe) => DropdownMenuItem(
                                    alignment: AlignmentDirectional.centerStart,
                                    value: classe,
                                    child: Text(classe),
                                  ))
                              .toList(),
                          onChanged: (s) {
                            setState(() {
                              buildContext
                                  .read<UserProvider>()
                                  .changeStanza(stanza: s!);
                              stanzaSelezionata =
                                  buildContext.read<UserProvider>().stanza;
                              ottieniDispositivi();
                            });

                            setState(() {
                              //TODO far si' che dispositivo cambi ogni volta che si cambia la classe
                            });
                          },
                        ),
                        Visibility(
                          visible: isDeviceVisible,
                          child: FormBuilderDropdown<String>(
                            name: 'dispositivo',
                            validator: FormBuilderValidators.required(
                                errorText: 'Seleziona un dispositivo'),
                            initialValue: dispositivoSelezionato,
                            decoration: InputDecoration(
                              labelText: 'Dispositivo',
                              suffix: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _formKey.currentState!.fields['dispositivo']
                                      ?.reset();
                                },
                              ),
                              hintText: 'Seleziona il dispositivo',
                            ),
                            items: nomiDispositiviFiltrati
                                .map((classe) => DropdownMenuItem(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      value: classe,
                                      child: Text(classe),
                                    ))
                                .toList(),
                          ),
                        ),
                        FormBuilderTextField(
                          decoration: const InputDecoration(
                            labelText: "Descrizione",
                          ),
                          name: 'descrizione',
                          initialValue: "",
                          validator: FormBuilderValidators.required(
                              errorText: "Questo campo non puo' essere vuoto"),
                        ),
                        PulsanteRoute(
                            route: "",
                            testo: "Invia i dati della segnalazione",
                            onPressed: () {
                              // inspect(_formKey.currentState?.fields);

                              _formKey.currentState?.saveAndValidate();

                              Map<String, String> formDaSpedire = {};

                              var form = _formKey.currentState?.fields;
                              // print(form.runtimeType);

                              form?.forEach((key, field) {
                                if (field.value == null) {
                                  throw ("Campo vuoto! in $key");
                                }
                                formDaSpedire.addAll({key: field.value});
                              });

                              formDaSpedire.addAll({
                                "id_utente":
                                    context.read<UserProvider>().userName
                              });
                              //                           print(
                              // "id_utente : ${context.read<UserProvider>().userName}");

                              if (!formDaSpedire["id_utente"]!
                                  .contains("@itiszuccante.edu.it")) {
                                throw ("id_utente NON VALIDO! id_utente:${formDaSpedire["id_utente"]}");
                              }

                              inviaSegnalazione(form: formDaSpedire);

                              //inviare la richiesta se è tutto idoneo
                            }),
                        Text(rispostaServer),
                      ]
                          .map((widget) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              child: widget))
                          .toList(growable: false),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: CustomWidget.barraApplicazioni(title: "Segnalazione"),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
  }

  Future<List<String>> ottieniNomeStanze() async {
    stanze = await (dao.getStanze());
    dispositivi = await (dao.getDispositivi());
    List<String> nomiStanze = [];

    for (var stanza in stanze) {
      nomiStanze.add(stanza.nome);
    }

    nomiStanze.sort();
    return nomiStanze;
  }

  void ottieniDispositivi() {
    //codiceStanza
    int codiceStanza = -1;

    for (int i = 0; i < stanze.length; i++) {
      if (stanze[i].nome == stanzaSelezionata) {
        codiceStanza = stanze[i].codice;
      }
    }

    //dispositiviFiltrati
    nomiDispositiviFiltrati.clear();
    for (int i = 0; i < dispositivi.length; i++) {
      if (dispositivi[i].codice_stanza == codiceStanza) {
        nomiDispositiviFiltrati.add(dispositivi[i].nome);
      }
    }
    setState(() {});
  }

  void mostraInvioSchermata() {
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

  void inviaSegnalazione({required Map<String, String> form}) async {
    // String datiForm =
    //     "id_utente=${form["id_utente"]}&tipo=${form["tipo"]!.toLowerCase()}&descrizione=${form["descrizione"]}&stanza=${form["stanza"]}&dispositivo=${form["dispositivo"]}";
    // String url =
    //     "http://192.168.1.124/P002_helpdesk/serverREST/formDaMobile?$datiForm";

    // print(url);
    // var response = await http.get(Uri.parse(url));

    form.update("tipo", (value) => form["tipo"]!.toLowerCase());
    form.update("categoria", (value) => form["categoria"]!.toLowerCase());

    print(json.encode(form));

    try {
      // httpClient = http.Client();
      String ipServer = _context.read<UserProvider>().ipServer;
      var response = await http.post(
          Uri.parse(
              "http://$ipServer/P002_helpdesk/serverREST/formDaMobile"),
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(form));

      if (response.statusCode == 200) {
        inspect(response.body);
        setState(() {
          rispostaServer = response.body;

          showDialog(
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    context.read<UserProvider>().changeStanza(stanza: "");
                    context
                        .read<UserProvider>()
                        .changeDispositivo(dispositivo: "");
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/");
                  },
                  child: AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 141, 204, 238),
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
                            Text("Segnalazione inviata con successo",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      PulsanteRoute(
                          route: "",
                          onPressed: () {
                            context
                                .read<UserProvider>()
                                .changeStanza(stanza: "");
                            context
                                .read<UserProvider>()
                                .changeDispositivo(dispositivo: "");
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/");
                          },
                          testo: "   OK   ")
                    ],
                  ),
                );
              });
        });
        // print(json.decode(response.body));
      }
    } catch (e) {
      print('Errore durante la richiesta HTTP: $e');
      setState(() {
        rispostaServer = e.toString();
      });
    } finally {
      // httpClient.close();
    }
  }
}
