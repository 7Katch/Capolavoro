import 'package:flutter/material.dart';
import 'package:helpdesk_mobile/database/dao/entities_dao.dart';
import 'package:helpdesk_mobile/database/database.dart';

class UserProvider extends ChangeNotifier {
  late String ipServer;
  late String password;
  late String userName;

  late AppDatabase database;
  late Dao dao;

  late String stanza;
  late String dispositivo;

  late int id_stanza;
  late int id_dispositivo;

  var stanze;

  UserProvider() {
    ipServer = "192.168.1.124";
    userName = "";
    password = "";
    stanza = "";
    dispositivo = "";
    $FloorAppDatabase
        .databaseBuilder('flutter_database.db')
        .build()
        .then((value) {
      database = value;
      dao = database.dao;

      stanze = dao.getStanze();
      id_dispositivo = 0;
      id_stanza = 0;
    });
  }

  void changeUserName({required String newUsername}) async {
    userName = newUsername;
    notifyListeners();
  }

  void changePassword({required String password}) async {
    this.password = password;
    notifyListeners();
  }

  void changeStanza({required String stanza}) async {
    this.stanza = stanza;
    notifyListeners();
  }

  void changeIdStanza({required int id}) async {
    id_stanza = id;
    notifyListeners();
  }

  void changeidDispositivo({required int id}) async {
    id_dispositivo = id;
    notifyListeners();
  }

  void changeDispositivo({required String dispositivo}) async {
    this.dispositivo = dispositivo;
    notifyListeners();
  }

  void changeIpServer({required String newIpServer}) async {
    ipServer = newIpServer;
    notifyListeners();
  }
}
