import 'dart:math';

class JokalariErronka {
  const JokalariErronka({
    required this.izena,
    required this.herrialdea,
    required this.posizioa,
    required this.ezaugarria,
    required this.deskribapena,
    required this.datuak,
    required this.galdera,
    required this.aukerak,
    required this.erantzunZuzena,
  });

  final String izena;
  final String herrialdea;
  final String posizioa;
  final String ezaugarria;
  final String deskribapena;
  final List<String> datuak;
  final String galdera;
  final List<String> aukerak;
  final String erantzunZuzena;

  String get inizialak {
    final zatiak = izena.split(' ');
    if (zatiak.length == 1) {
      return zatiak.first.substring(0, min(2, zatiak.first.length)).toUpperCase();
    }

    return '${zatiak.first.substring(0, 1)}${zatiak.last.substring(0, 1)}'
        .toUpperCase();
  }
}
