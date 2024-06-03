import 'package:floor/floor.dart';
import '../models/entities.dart';

@dao
abstract class Dao {
  //TODO Piano
  @Query('SELECT * FROM piano')
  Future<List<Piano>> getPiani();

  @insert
  Future<void> inserisciPiano(Piano piano);

  @delete
  Future<void> cancellaPiano(Piano piano);

  @Query('DELETE FROM piano WHERE TRUE')
  Future<void> cancellaTuttiPiani();

  //TODO Stanza
  @Query('SELECT * FROM stanza')
  Future<List<Stanza>> getStanze();


  @Query('SELECT * FROM stanza WHERE codice = :codice')
  Future<List<Stanza>> getStanzaById(int codice);

  @insert
  Future<void> inserisciStanza(Stanza stanza);

  @delete
  Future<void> cancellaStanza(Stanza stanza);

  @Query('DELETE FROM stanza')
  Future<void> cancellaTutteLeStanze();

  //TODO Dispositivo
  @Query('SELECT * FROM Dispositivo')
  Future<List<Dispositivo>> getDispositivi();

  @Query('SELECT * FROM dispositivo WHERE codice = :codice')
  Future<List<Dispositivo>> getDispositivoById(int codice);

  @Query('SELECT * FROM Dispositivo WHERE codice_stanza = :codice_stanza')
  Future<List<Dispositivo>> getDispositiviByStanza(int codice_stanza);

  @Query('DELETE FROM dispositivo')
  Future<void> cancellaTuttiIDispositivi();

  @insert
  Future<void> inserisciDispositivo(Dispositivo dispositivo);

  @delete
  Future<void> cancellaDispositivo(Dispositivo dispositivo);
}
