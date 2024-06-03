import 'package:floor/floor.dart';

enum TipoPiano {
  terra("terra"),
  primo("primo"),
  secondo("secondo");

  final String tipo;
  const TipoPiano(this.tipo);
}

@Entity(tableName: 'piano')
class Piano {
  @PrimaryKey(autoGenerate: false)
  final int codice;
  final TipoPiano nome; // ('terra','primo','secondo')
  Piano(this.codice, this.nome);
}

// ('laboratorio','aula','bagno','ufficio','bar')
enum TipoStanza {
  laboratorio("laboratorio"),
  aula("aula"),
  bagno("bagno"),
  ufficio("ufficio"),
  bar("bar");

  final String tipo;
  const TipoStanza(this.tipo);
}

@Entity(
  tableName: 'stanza',
  foreignKeys: [
    ForeignKey(
        childColumns: ['piano'], parentColumns: ['codice'], entity: Piano)
  ],
)
class Stanza {
  @PrimaryKey(autoGenerate: true)
  final int codice;
  final String nome;
  final int piano;
  final TipoStanza tipo; // ('laboratorio','aula','bagno','ufficio','bar')
  Stanza(this.codice, this.nome, this.piano, this.tipo);
}


enum TipoDispositivo {
  portatile("portatile"),
  fisso("fisso");

  final String tipo;
  const TipoDispositivo(this.tipo);
}


@Entity(
  foreignKeys: [
    ForeignKey(
        childColumns: ['codice_stanza'],
        parentColumns: ['codice'],
        entity: Stanza)
  ],
)
class Dispositivo {
  @PrimaryKey(autoGenerate: true)
  final int codice;
  final String nome;
  final TipoDispositivo tipo;
  final int codice_stanza;

  Dispositivo(this.codice, this.nome, this.tipo, this.codice_stanza);
}
