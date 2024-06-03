import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpdesk_mobile/Animation/FadeAnimation.dart';
import 'package:helpdesk_mobile/custom_widget/custom_widget.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:helpdesk_mobile/providers/user_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  var googleFonts = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);

  final _formKey = GlobalKey<FormBuilderState>();

  String rispostaServer = "";

  String? errorPassword;
  String? errorEmail;
  bool _isPasswordObscured = false;
  late BuildContext buildContext;
  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        child: Scaffold(
            // drawer: const NavBar(),
            // appBar: CustomWidget.barraApplicazioni(title: ""),
            body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.blue[900]!, Colors.blue[800]!, Colors.blue[400]!],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                      delay: 0.8,
                      child: Text("Login",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 40)),
                    ),
                    FadeAnimation(
                      delay: 0.5,
                      child: Text("Bentornato",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 16)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Center(
                    child: SingleChildScrollView(
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centra il contenuto in verticale
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Centra il contenuto in orizzontale
                          children: [
                            FadeAnimation(
                              delay: 1,
                              child: FormBuilderTextField(
                                decoration: InputDecoration(
                                    labelText: "Email", errorText: errorEmail),
                                name: 'email',
                                initialValue: "davide.yeh@itiszuccante.edu.it",
                                validator: FormBuilderValidators.required(
                                    errorText:
                                        "Questo campo non puo' essere vuoto"),
                              ),
                            ),
                            FadeAnimation(
                              delay: 1.2,
                              child: FormBuilderTextField(
                                obscureText: !_isPasswordObscured,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  errorText: errorPassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordObscured
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordObscured =
                                            !_isPasswordObscured; // Cambia lo stato di obscuredText
                                      });
                                    },
                                  ),
                                ),
                                name: 'password',
                                initialValue: "password1234",
                                validator: FormBuilderValidators.required(
                                    errorText:
                                        "Questo campo non puo' essere vuoto"),
                              ),
                            ),
                            Text(rispostaServer),
                            FadeAnimation(
                              delay: 1.3,
                              child: PulsanteRoute(
                                route: "",
                                testo: "             Login             ",
                                onPressed: () {
                                  _formKey.currentState?.saveAndValidate();
                                  Map<String, String> formDaSpedire = {};

                                  var form = _formKey.currentState?.fields;
                                  form?.forEach((key, field) {
                                    if (field.value == null) {
                                      throw ("Campo vuoto! in $key");
                                    }
                                    formDaSpedire.addAll({key: field.value});
                                  });

                                  // formDaSpedire.addAll({
                                  //   "id_utente":
                                  //       context.read<UserProvider>().userName
                                  // });

                                  richiestaLogin(form: formDaSpedire).then((v) {
                                    var dati = jsonDecode(v);

                                    inspect(dati);
                                    if (dati["messaggio"]
                                            .toString()
                                            .compareTo("validato") ==
                                        0) {
                                      errorPassword = null;
                                      errorEmail = null;
                                      context
                                          .read<UserProvider>()
                                          .changeUserName(
                                              newUsername: dati["email"]);
                                      context
                                          .read<UserProvider>()
                                          .changePassword(
                                              password: dati["token"]);
                                      Navigator.pushNamed(context, "/");
                                    } else {
                                      errorPassword =
                                          "Email o password sbagliata";
                                      errorEmail = "";
                                    }
                                    setState(() {});
                                  });
                                },
                              ),
                            ),
                          ]
                              .map((widget) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: widget,
                                  ))
                              .toList(growable: false),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Future<String> richiestaLogin({required Map<String, String> form}) async {
    String ipServer = buildContext.read<UserProvider>().ipServer;
    var response = await http.post(
        Uri.parse("http://$ipServer/P002_helpdesk/serverREST/loginMobile"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(form));
    // var response = await http.get(
    //   Uri.parse("http://$ipServer/P002_helpdesk/serverREST/loginMobile"),
    // );

    // rispostaServer = response.body;

    return response.body;
  }
}
//leading: label == 'Nome' ? Icon(Icons.person) : label == 'Cognome' ? Icon(Icons.person) : label == 'Area' ? Icon(Icons.location_city) : Icon(Icons.badge),
