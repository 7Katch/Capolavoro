// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'models/entities.dart';
import 'dao/entities_dao.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Piano, Stanza, Dispositivo])
abstract class AppDatabase extends FloorDatabase {
  Dao get dao;

}
