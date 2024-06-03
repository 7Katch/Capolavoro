import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/Animation/FadeAnimation.dart';
import 'package:helpdesk_mobile/providers/user_provider.dart';
import 'package:helpdesk_mobile/widget/messaggi.dart';
import 'package:helpdesk_mobile/widget/scan.dart';

import 'package:provider/provider.dart';

//DATABASE
import 'database/database.dart';
import 'database/models/entities.dart';
import 'database/dao/entities_dao.dart';

//CUSTOM WIDGET
import 'widget/login.dart';
import 'widget/history.dart';
import 'widget/pag1.dart';
import 'widget/pag2.dart';
import 'widget/stanze.dart';
import 'widget/dispositivi.dart';
import 'widget/segnalazione.dart';

import 'custom_widget/custom_widget.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  Dao dao = database.dao;

  //? DECCOMENTA questa riga se non hai ancora il database popolato
  // await insertDatabase(dao);

  runApp(const MyApp());
}

Future<void> insertDatabase(Dao dao) async {
  await dao.cancellaTuttiIDispositivi();
  await dao.cancellaTutteLeStanze();
  await dao.cancellaTuttiPiani();

  //TODO Inserimento dei piani
  List<Piano> piani = [
    Piano(0, TipoPiano.terra),
    Piano(1, TipoPiano.primo),
    Piano(2, TipoPiano.secondo)
  ];

  //TODO Inserimento delle stanze
  List<Stanza> stanze = [
    Stanza(1, "3IA", 0, TipoStanza.aula),
    Stanza(2, "4IA", 0, TipoStanza.aula),
    Stanza(3, "5IA", 0, TipoStanza.aula),
    Stanza(4, "3IB", 0, TipoStanza.aula),
    Stanza(5, "4IB", 0, TipoStanza.aula),
    Stanza(6, "5IB", 0, TipoStanza.aula),
    Stanza(7, "Aula relax", 0, TipoStanza.aula),
    Stanza(8, "3ID", 0, TipoStanza.aula),
    Stanza(9, "3IE", 0, TipoStanza.aula),
    Stanza(10, "LAS", 0, TipoStanza.laboratorio),
    Stanza(11, "Locale A.T. LAS", 0, TipoStanza.ufficio),
    Stanza(12, "LLM", 0, TipoStanza.laboratorio),
    Stanza(13, "LAP2", 0, TipoStanza.laboratorio),
    Stanza(14, "LAM", 0, TipoStanza.laboratorio),
    Stanza(15, "WC1", 0, TipoStanza.bagno),
    Stanza(16, "WC2", 0, TipoStanza.bagno),
    Stanza(17, "LASA", 0, TipoStanza.laboratorio),
    Stanza(18, "OEN1", 0, TipoStanza.laboratorio),
    Stanza(19, "Palestra", 0, TipoStanza.aula),
    Stanza(20, "Spogliatoio maschile", 0, TipoStanza.bagno),
    Stanza(21, "Spogliatoio femminile", 0, TipoStanza.bagno),
    Stanza(22, "4EA-TA", 1, TipoStanza.aula),
    Stanza(23, "4TA", 1, TipoStanza.aula),
    Stanza(24, "5EA-TA", 1, TipoStanza.aula),
    Stanza(25, "5TA", 1, TipoStanza.aula),
    Stanza(26, "3EA", 1, TipoStanza.aula),
    Stanza(27, "4AB", 1, TipoStanza.aula),
    Stanza(28, "5AB", 1, TipoStanza.aula),
    Stanza(29, "4IC", 1, TipoStanza.aula),
    Stanza(30, "3IC", 1, TipoStanza.aula),
    Stanza(31, "5IC", 1, TipoStanza.aula),
    Stanza(32, "3AA", 1, TipoStanza.aula),
    Stanza(33, "4AA", 1, TipoStanza.aula),
    Stanza(34, "5AA", 1, TipoStanza.aula),
    Stanza(35, "Musica", 1, TipoStanza.aula),
    Stanza(36, "WC3", 1, TipoStanza.bagno),
    Stanza(37, "WC4", 1, TipoStanza.bagno),
    Stanza(38, "Sala lettura", 1, TipoStanza.aula),
    Stanza(39, "Deposito libri", 1, TipoStanza.aula),
    Stanza(40, "Aula insegnanti", 1, TipoStanza.aula),
    Stanza(41, "Locale A.T. LAP1", 1, TipoStanza.ufficio),
    Stanza(42, "LAP1", 1, TipoStanza.laboratorio),
    Stanza(43, "CIM/SALA SERVER", 1, TipoStanza.ufficio),
    Stanza(44, "OEN2", 1, TipoStanza.laboratorio),
    Stanza(45, "WC5", 1, TipoStanza.bagno),
    Stanza(46, "WC6", 1, TipoStanza.bagno),
    Stanza(47, "BAR", 1, TipoStanza.bar),
    Stanza(48, "LEN5", 2, TipoStanza.laboratorio),
    Stanza(49, "LEN4", 2, TipoStanza.laboratorio),
    Stanza(50, "Ufficio tecnico", 2, TipoStanza.ufficio),
    Stanza(51, "Segreteria didattica", 2, TipoStanza.ufficio),
    Stanza(52, "PCTO", 2, TipoStanza.ufficio),
    Stanza(53, "Locale A.T.", 2, TipoStanza.ufficio),
    Stanza(54, "Vice presidenza", 2, TipoStanza.ufficio),
    Stanza(55, "Presidenza", 2, TipoStanza.ufficio),
    Stanza(56, "Locale", 2, TipoStanza.ufficio),
    Stanza(57, "Ufficio DSGA", 2, TipoStanza.ufficio),
    Stanza(58, "Ufficio personale", 2, TipoStanza.ufficio),
    Stanza(59, "Magazzino", 2, TipoStanza.ufficio),
  ];

  //TODO Inserimento dispositivi

  List<Dispositivo> dispositivi = [
    //? LAP1
    Dispositivo(1, "LAP1-WS01", TipoDispositivo.fisso, 42),
    Dispositivo(2, "LAP1-WS02", TipoDispositivo.fisso, 42),
    Dispositivo(3, "LAP1-WS03", TipoDispositivo.fisso, 42),
    Dispositivo(4, "LAP1-WS04", TipoDispositivo.fisso, 42),
    Dispositivo(5, "LAP1-WS05", TipoDispositivo.fisso, 42),
    Dispositivo(6, "LAP1-WS06", TipoDispositivo.fisso, 42),
    Dispositivo(7, "LAP1-WS07", TipoDispositivo.fisso, 42),
    Dispositivo(8, "LAP1-WS08", TipoDispositivo.fisso, 42),
    Dispositivo(9, "LAP1-WS09", TipoDispositivo.fisso, 42),
    Dispositivo(10, "LAP1-WS10", TipoDispositivo.fisso, 42),
    Dispositivo(11, "LAP1-WS11", TipoDispositivo.fisso, 42),
    Dispositivo(12, "LAP1-WS12", TipoDispositivo.fisso, 42),
    Dispositivo(13, "LAP1-WS13", TipoDispositivo.fisso, 42),
    Dispositivo(14, "LAP1-WS14", TipoDispositivo.fisso, 42),
    Dispositivo(15, "LAP1-WS15", TipoDispositivo.fisso, 42),
    Dispositivo(16, "LAP1-WS16", TipoDispositivo.fisso, 42),
    Dispositivo(17, "LAP1-WS17", TipoDispositivo.fisso, 42),
    Dispositivo(18, "LAP1-WS18", TipoDispositivo.fisso, 42),
    Dispositivo(19, "LAP1-WS19", TipoDispositivo.fisso, 42),
    Dispositivo(20, "LAP1-WS20", TipoDispositivo.fisso, 42),
    Dispositivo(21, "LAP1-WS21", TipoDispositivo.fisso, 42),
    Dispositivo(22, "LAP1-WS22", TipoDispositivo.fisso, 42),
    Dispositivo(23, "LAP1-WS23", TipoDispositivo.fisso, 42),
    Dispositivo(24, "LAP1-WS24", TipoDispositivo.fisso, 42),
    Dispositivo(25, "LAP1-WS25", TipoDispositivo.fisso, 42),
    Dispositivo(26, "LAP1-WS26", TipoDispositivo.fisso, 42),
    Dispositivo(27, "LAP1-WS27", TipoDispositivo.fisso, 42),
    Dispositivo(28, "LAP1-WS28", TipoDispositivo.fisso, 42),
    Dispositivo(29, "LAP1-WS29", TipoDispositivo.fisso, 42),
    Dispositivo(30, "LAP1-WS30", TipoDispositivo.fisso, 42),
    Dispositivo(31, "LAP1-WS31", TipoDispositivo.fisso, 42),

    //LAP2
    Dispositivo(32, "LAP2-WS01", TipoDispositivo.fisso, 13),
    Dispositivo(33, "LAP2-WS02", TipoDispositivo.fisso, 13),
    Dispositivo(34, "LAP2-WS03", TipoDispositivo.fisso, 13),
    Dispositivo(35, "LAP2-WS04", TipoDispositivo.fisso, 13),
    Dispositivo(36, "LAP2-WS05", TipoDispositivo.fisso, 13),
    Dispositivo(37, "LAP2-WS06", TipoDispositivo.fisso, 13),
    Dispositivo(38, "LAP2-WS07", TipoDispositivo.fisso, 13),
    Dispositivo(39, "LAP2-WS08", TipoDispositivo.fisso, 13),
    Dispositivo(40, "LAP2-WS09", TipoDispositivo.fisso, 13),
    Dispositivo(41, "LAP2-WS10", TipoDispositivo.fisso, 13),
    Dispositivo(42, "LAP2-WS11", TipoDispositivo.fisso, 13),
    Dispositivo(43, "LAP2-WS12", TipoDispositivo.fisso, 13),
    Dispositivo(44, "LAP2-WS13", TipoDispositivo.fisso, 13),
    Dispositivo(45, "LAP2-WS14", TipoDispositivo.fisso, 13),
    Dispositivo(46, "LAP2-WS15", TipoDispositivo.fisso, 13),
    Dispositivo(47, "LAP2-WS16", TipoDispositivo.fisso, 13),
    Dispositivo(48, "LAP2-WS17", TipoDispositivo.fisso, 13),
    Dispositivo(49, "LAP2-WS18", TipoDispositivo.fisso, 13),
    Dispositivo(50, "LAP2-WS19", TipoDispositivo.fisso, 13),
    Dispositivo(51, "LAP2-WS20", TipoDispositivo.fisso, 13),
    Dispositivo(52, "LAP2-WS21", TipoDispositivo.fisso, 13),
    Dispositivo(53, "LAP2-WS22", TipoDispositivo.fisso, 13),
    Dispositivo(54, "LAP2-WS23", TipoDispositivo.fisso, 13),
    Dispositivo(55, "LAP2-WS24", TipoDispositivo.fisso, 13),
    Dispositivo(56, "LAP2-WS25", TipoDispositivo.fisso, 13),
    Dispositivo(57, "LAP2-WS26", TipoDispositivo.fisso, 13),
    Dispositivo(58, "LAP2-WS27", TipoDispositivo.fisso, 13),
    Dispositivo(59, "LAP2-WS28", TipoDispositivo.fisso, 13),
    Dispositivo(60, "LAP2-WS29", TipoDispositivo.fisso, 13),
    Dispositivo(61, "LAP2-WS30", TipoDispositivo.fisso, 13),

    //LAS

    Dispositivo(62, "LAS-WS01", TipoDispositivo.fisso, 10),
    Dispositivo(63, "LAS-WS02", TipoDispositivo.fisso, 10),
    Dispositivo(64, "LAS-WS03", TipoDispositivo.fisso, 10),
    Dispositivo(65, "LAS-WS04", TipoDispositivo.fisso, 10),
    Dispositivo(66, "LAS-WS05", TipoDispositivo.fisso, 10),
    Dispositivo(67, "LAS-WS06", TipoDispositivo.fisso, 10),
    Dispositivo(68, "LAS-WS07", TipoDispositivo.fisso, 10),
    Dispositivo(69, "LAS-WS08", TipoDispositivo.fisso, 10),
    Dispositivo(70, "LAS-WS09", TipoDispositivo.fisso, 10),
    Dispositivo(71, "LAS-WS10", TipoDispositivo.fisso, 10),
    Dispositivo(72, "LAS-WS11", TipoDispositivo.fisso, 10),
    Dispositivo(73, "LAS-WS12", TipoDispositivo.fisso, 10),
    Dispositivo(74, "LAS-WS13", TipoDispositivo.fisso, 10),
    Dispositivo(75, "LAS-WS14", TipoDispositivo.fisso, 10),
    Dispositivo(76, "LAS-WS15", TipoDispositivo.fisso, 10),
    Dispositivo(77, "LAS-WS16", TipoDispositivo.fisso, 10),
    Dispositivo(78, "LAS-WS17", TipoDispositivo.fisso, 10),
    Dispositivo(79, "LAS-WS18", TipoDispositivo.fisso, 10),
    Dispositivo(80, "LAS-WS19", TipoDispositivo.fisso, 10),
    Dispositivo(81, "LAS-WS20", TipoDispositivo.fisso, 10),
    Dispositivo(82, "LAS-WS21", TipoDispositivo.fisso, 10),
    Dispositivo(83, "LAS-WS22", TipoDispositivo.fisso, 10),
    Dispositivo(84, "LAS-WS23", TipoDispositivo.fisso, 10),
    Dispositivo(85, "LAS-WS24", TipoDispositivo.fisso, 10),
    Dispositivo(86, "LAS-WS25", TipoDispositivo.fisso, 10),
    Dispositivo(87, "LAS-WS26", TipoDispositivo.fisso, 10),
    Dispositivo(88, "LAS-WS27", TipoDispositivo.fisso, 10),
    Dispositivo(89, "LAS-WS28", TipoDispositivo.fisso, 10),
    Dispositivo(90, "LAS-WS29", TipoDispositivo.fisso, 10),
    Dispositivo(91, "LAS-WS30", TipoDispositivo.fisso, 10),

    //LLM
    Dispositivo(92, "LLM-WS01", TipoDispositivo.fisso, 12),
    Dispositivo(93, "LLM-WS02", TipoDispositivo.fisso, 12),
    Dispositivo(94, "LLM-WS03", TipoDispositivo.fisso, 12),
    Dispositivo(95, "LLM-WS04", TipoDispositivo.fisso, 12),
    Dispositivo(96, "LLM-WS05", TipoDispositivo.fisso, 12),
    Dispositivo(97, "LLM-WS06", TipoDispositivo.fisso, 12),
    Dispositivo(98, "LLM-WS07", TipoDispositivo.fisso, 12),
    Dispositivo(99, "LLM-WS08", TipoDispositivo.fisso, 12),
    Dispositivo(100, "LLM-WS09", TipoDispositivo.fisso, 12),
    Dispositivo(101, "LLM-WS10", TipoDispositivo.fisso, 12),
    Dispositivo(102, "LLM-WS11", TipoDispositivo.fisso, 12),
    Dispositivo(103, "LLM-WS12", TipoDispositivo.fisso, 12),
    Dispositivo(104, "LLM-WS13", TipoDispositivo.fisso, 12),
    Dispositivo(105, "LLM-WS14", TipoDispositivo.fisso, 12),
    Dispositivo(106, "LLM-WS15", TipoDispositivo.fisso, 12),
    Dispositivo(107, "LLM-WS16", TipoDispositivo.fisso, 12),
    Dispositivo(108, "LLM-WS17", TipoDispositivo.fisso, 12),
    Dispositivo(109, "LLM-WS18", TipoDispositivo.fisso, 12),
    Dispositivo(110, "LLM-WS19", TipoDispositivo.fisso, 12),
    Dispositivo(111, "LLM-WS20", TipoDispositivo.fisso, 12),
    Dispositivo(112, "LLM-WS21", TipoDispositivo.fisso, 12),
    Dispositivo(113, "LLM-WS22", TipoDispositivo.fisso, 12),
    Dispositivo(114, "LLM-WS23", TipoDispositivo.fisso, 12),
    Dispositivo(115, "LLM-WS24", TipoDispositivo.fisso, 12),
    Dispositivo(116, "LLM-WS25", TipoDispositivo.fisso, 12),
    Dispositivo(117, "LLM-WS26", TipoDispositivo.fisso, 12),
    Dispositivo(118, "LLM-WS27", TipoDispositivo.fisso, 12),
    Dispositivo(119, "LLM-WS28", TipoDispositivo.fisso, 12),
    Dispositivo(120, "LLM-WS29", TipoDispositivo.fisso, 12),

    Dispositivo(121, "OEN1-WS01", TipoDispositivo.fisso, 18),
    Dispositivo(122, "OEN1-WS02", TipoDispositivo.fisso, 18),
    Dispositivo(123, "OEN1-WS03", TipoDispositivo.fisso, 18),
    Dispositivo(124, "OEN1-WS04", TipoDispositivo.fisso, 18),
    Dispositivo(125, "OEN1-WS05", TipoDispositivo.fisso, 18),
    Dispositivo(126, "OEN1-WS06", TipoDispositivo.fisso, 18),
    Dispositivo(127, "OEN1-WS07", TipoDispositivo.fisso, 18),
    Dispositivo(128, "OEN1-WS08", TipoDispositivo.fisso, 18),
    Dispositivo(129, "OEN1-WS09", TipoDispositivo.fisso, 18),
    Dispositivo(130, "OEN1-WS10", TipoDispositivo.fisso, 18),
    Dispositivo(131, "OEN1-WS11", TipoDispositivo.fisso, 18),
    Dispositivo(132, "OEN1-WS12", TipoDispositivo.fisso, 18),
    Dispositivo(133, "OEN1-WS13", TipoDispositivo.fisso, 18),
    Dispositivo(134, "OEN1-WS14", TipoDispositivo.fisso, 18),
    Dispositivo(135, "OEN1-WS15", TipoDispositivo.fisso, 18),
    Dispositivo(136, "OEN1-WS16", TipoDispositivo.fisso, 18),
    Dispositivo(137, "OEN1-WS17", TipoDispositivo.fisso, 18),
    Dispositivo(138, "OEN1-WS18", TipoDispositivo.fisso, 18),
    Dispositivo(139, "OEN1-WS19", TipoDispositivo.fisso, 18),
    Dispositivo(140, "OEN1-WS20", TipoDispositivo.fisso, 18),
    Dispositivo(141, "OEN1-WS21", TipoDispositivo.fisso, 18),
    Dispositivo(142, "OEN1-WS22", TipoDispositivo.fisso, 18),
    Dispositivo(143, "OEN1-WS23", TipoDispositivo.fisso, 18),
    Dispositivo(144, "OEN1-WS24", TipoDispositivo.fisso, 18),
    Dispositivo(145, "OEN1-WS25", TipoDispositivo.fisso, 18),
    Dispositivo(146, "OEN1-WS26", TipoDispositivo.fisso, 18),
    Dispositivo(147, "OEN1-WS27", TipoDispositivo.fisso, 18),
    Dispositivo(148, "OEN1-WS28", TipoDispositivo.fisso, 18),
    Dispositivo(149, "OEN1-CAT01", TipoDispositivo.fisso, 18),
    Dispositivo(150, "OEN1-CAT02", TipoDispositivo.fisso, 18),
    Dispositivo(151, "WS01", TipoDispositivo.fisso, 3),
    Dispositivo(152, "WS01", TipoDispositivo.fisso, 1),
    Dispositivo(153, "WS01", TipoDispositivo.fisso, 32),
  ];

  try {
    //TODO Piani
    for (var piano in piani) {
      await dao.inserisciPiano(piano);
    }

    //TODO Stanze
    for (var stanza in stanze) {
      await dao.inserisciStanza(stanza);
    }

    //TODO Dispositivi
    for (var dispositivo in dispositivi) {
      await dao.inserisciDispositivo(dispositivo);
    }
  } catch (e) {
    print(e.toString());
    print("Chiave primaria duplicata");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: "/",
        routes: {
          "/": (context) => const MyHomePage(title: 'Helpdesk'),
          "/pag1": (context) => const Pag1(),
          "/login": (context) => const Login(),
          "/pag2": (context) => const Pag2(),
          "/stanze": (context) => const Stanze(),
          "/dispositivi": (context) => const Dispositivi(),
          "/history": (context) => const History(),
          "/segnalazione": (context) => const Segnalazione(),
          "/messaggi": (context) => const Messaggi(),
          "/scan": (context) => const Scan(),
        },

        title: 'Helpdesk',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: "Raleway",
        ),
        // home: const MyHomePage(title: 'ClientREST'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //TODO VARIABILI
  var risultato = "";

  List<Widget> infoSegnalazioni = [];
  late List<Stanza> stanze;

  List<Map<String, dynamic>> infoStanze = [];
  List<String> stanze_filtrate = [];
  List<Widget> stanze_illustrate = [];

  //per la bottomAppNavigator
  int currentPageIndex = 0;

  bool pressed = false;

  String filtroNomeStanza = '';

  // ignore: prefer_typing_uninitialized_variables
  var database;
  // ignore: prefer_typing_uninitialized_variables
  var dao;

  late Future<List> _datiStanze;
  BuildContext? buildContext;

  TextEditingController testoStanza = TextEditingController(text: "");

  // TextEditingController testoEmail = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();

    connessioneDatabase();
    Stream<List<dynamic>> streamSegnalazioni =
        richiediSegnalazioni(const Duration(seconds: 10));

    streamSegnalazioni.listen((lista) {
      // print("risposta stream ottenuta");
      infoSegnalazioni.clear();
      aggiornaSegnalazioni(lista);
    });
    //Per evitare che il futureBuilder venga eseguito ogni volta dal setState
    _datiStanze = richiediStanze();
  }

  Stream<List<dynamic>> richiediSegnalazioni(Duration interval) async* {
    // while (buildContext == null) {}
    while (true) {
      // ignore: use_build_context_synchronously

      String ipServer = buildContext!.read<UserProvider>().ipServer;
      http.Response response;
      try {
        response = await http.get(Uri.parse(
            "http://$ipServer/P002_helpdesk/serverREST/segnalazioni"));
        if (response.statusCode == 200) {
          // Gestisci la risposta dal server
          yield json.decode(response.body);
        } else {
          // Gestisci altri codici di stato della risposta (se necessario)
          throw Exception(
              'Errore nella richiesta HTTP: ${response.statusCode}');
        }
      } catch (e) {
        yield [
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:23",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:26",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:23",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:26",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:23",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:26",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:23",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:26",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:23",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
          {
            "id_utente": "davide.yeh@itiszuccante.edu.it",
            "data": "2024-04-29 23:44:26",
            "descrizione": "Segnalazione inviata dal telefono",
            "tipo": "tecnico",
            "stato": "non assegnato",
            "id_dispositivo": 151,
            "id_stanza": 3
          },
        ];
      }

      await Future.delayed(interval);
    }
  }

  void aggiornaSegnalazioni(lista) async {
    //ultime 10 segnalazioni

    for (int i = lista.length - 10; i < lista.length; i++) {
      var codiceDispositivo = lista[i]["id_dispositivo"];
      var codiceStanza = lista[i]["id_stanza"];
      String parola = "";
      if (codiceDispositivo != null) {
        var infoDisp = await (dao as Dao).getDispositivoById(codiceDispositivo);
        var infoStanza = await (dao as Dao).getStanzaById(codiceStanza);
        if (infoDisp[0].nome.contains("-")) {
          parola = infoDisp[0].nome;
        } else {
          parola = "${infoStanza[0].nome} ${infoDisp[0].nome}";
        }
      } else {
        var infoStanza = await (dao as Dao).getStanzaById(codiceStanza);
        parola = infoStanza[0].nome;
      }

      infoSegnalazioni.add(FadeAnimation(
        delay: 0.1,
        child: Card(
          color: const Color.fromARGB(255, 122, 198, 248),
          // width: 100,
          // height: 100,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: 170,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Text("LAP1"),
              Icon(
                  codiceDispositivo != null
                      ? Icons.smartphone
                      : Icons.room_preferences_rounded,
                  color: const Color.fromARGB(255, 15, 66, 107),
                  size: 50),
              Text(
                parola,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Text(lista[0]["data"].substring(0, 10),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  )),
              ElevatedButton(
                child: Text("Visualizza",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 97, 131, 205),
                    )),
                onPressed: () {
                  // Navigator.pushNamed(context, "/history");
                },
              ),
            ]),
          ),
        ),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext buildContext) {
    this.buildContext = buildContext;

    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(
              color: Color.fromARGB(
                  255, 191, 20, 8)), // Cambia il colore delle icone qui
        ),
        child: const NavBar(),
      ),
      appBar: CustomWidget.barraApplicazioni(title: "Helpdesk"),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 42, 149, 237),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 36, 191, 242),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon:
                Icon(Icons.home, color: Color.fromARGB(255, 15, 66, 107)),
            icon: Icon(Icons.home_outlined,
                color: Color.fromARGB(255, 15, 66, 107)),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon:
                Icon(Icons.school, color: Color.fromARGB(255, 15, 66, 107)),
            icon: Icon(Icons.school_outlined,
                color: Color.fromARGB(255, 15, 66, 107)),
            label: 'Stanze',
          ),
        ],
      ),
      body: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Benvenuto",
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        color: Colors.lightBlue.shade900,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(context.read<UserProvider>().userName,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.lightBlue.shade900,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Ultime segnalazioni",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.lightBlue.shade900,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: infoSegnalazioni.length,
                  itemBuilder: (context, index) {
                    return infoSegnalazioni[index];
                  },
                ),
              ),
              Wrap(
                children: [
                  Center(
                    child: Wrap(
                      spacing: 20,
                      direction: Axis.vertical,
                      children: [
                        // Text(
                        //   buildContext.watch<UserProvider>().userName,
                        // ),
                        const SizedBox(
                          height: 60,
                        ),
                        if (buildContext.read<UserProvider>().userName == "")
                          const PulsanteRoute(
                              route: "/login",
                              testo: "            Login            "),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        //Pagina delle stanze
        SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  // onChanged: (s) {
                  // filtraStanzaPerNome(nome: s, context: buildContext);
                  // print("hello world");
                  // },
                  controller: testoStanza,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Cerca il nome della classe")),
                ),
              ),
              PulsanteRoute(
                route: "",
                testo: "Cerca",
                onPressed: () {
                  setState(() {});
                  FocusManager.instance.primaryFocus?.unfocus();
                  // testoStanza.clear();
                },
              ),
              Text("Stanze",
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 15, 66, 107),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
              FutureBuilder(
                  future: _datiStanze,
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      List info = snapshot.data!;
                      stanze_illustrate.clear();
                      if (info.isEmpty) {
                        return Text(
                          "Non esistono dispositivi nella stanza cercata",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        );
                      }

                      //applicare qua il filtro
                      filtraStanzaPerNome(nome: "", context: buildContext);

                      for (int i = 0; i < info.length; i++) {
                        var row = info[i] as Stanza;

                        for (int j = 0; j < stanze_filtrate.length; j++) {
                          if (stanze_filtrate[j] == row.nome) {
                            infoStanze.add({
                              "dati": row,
                            });

                            stanze_illustrate.add(FadeXAnimation(
                              delay: i + 0.5,
                              child: creaWidgetStanza(
                                  nome: row.nome,
                                  tipo: row.tipo.tipo,
                                  buildContext: buildContext,
                                  piano: row.piano),
                            ));
                          }
                        }
                      }

                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: stanze_illustrate,
                      );
                    }
                  })),
            ]),
          ),
        ),
      ][currentPageIndex],
    );
  }

  // Function to filter products by price
  void filtraStanzaPerNome(
      {required String nome, required BuildContext context}) {
    if (nome == "") {
      for (var s in stanze) {
        stanze_filtrate.add(s.nome);
      }
    }
    String testoFiltrato = testoStanza.text;

    stanze_filtrate.clear();

    for (var s in stanze) {
      if (s.nome.contains(testoFiltrato)) {
        stanze_filtrate.add(s.nome);
      }
    }
  }

  Widget creaWidgetStanza(
      {required String nome,
      required String tipo,
      required BuildContext buildContext,
      required int piano}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SizedBox(
        height: 100,
        child: Card(
          color: const Color.fromARGB(255, 229, 237, 242),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.school),
                title: Text(nome),
                subtitle: Text("piano $piano"),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        buildContext
                            .read<UserProvider>()
                            .changeStanza(stanza: nome);
                        Navigator.pushNamed(buildContext, "/dispositivi");
                      },
                      icon: const Icon(Icons.phone_android),
                    ),
                    IconButton(
                      onPressed: () {
                        buildContext
                            .read<UserProvider>()
                            .changeStanza(stanza: nome);
                        Navigator.pushNamed(buildContext, "/segnalazione");
                      },
                      icon: const Icon(Icons.flag),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> connessioneDatabase() async {
    if (database == null || dao == null) {
      database = await $FloorAppDatabase
          .databaseBuilder('flutter_database.db')
          .build();
      dao = database.dao;
      print("creato database");
    }
  }

  Future<List> richiediStanze() async {
    //simulazione della richiesta GET
    await Future.delayed(const Duration(seconds: 1));
    stanze = await dao.getStanze();
    return stanze;
  }
}
