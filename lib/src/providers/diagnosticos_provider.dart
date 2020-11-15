import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_diagnosticos/src/models/diagnostico_model.dart';

class DiagnosticosProvider {
  String _url = "https://tb-prediction-api.azurewebsites.net/api";

  int _popularesPage = 0;
  bool _cargando = false;

  List<Diagnostico> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Diagnostico>>.broadcast();

  Function(List<Diagnostico>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Diagnostico>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Diagnostico>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Diagnosticos.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Diagnostico>> getEnCines() async {
    final url = Uri.https(_url, '/tests');

    return await _procesarRespuesta(url);
  }

  Future<List<Diagnostico>> getPopular() async {
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url =
        Uri.https(_url, '3/movie/popular', {'page': _popularesPage.toString()});

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;

    return resp;
  }
}
