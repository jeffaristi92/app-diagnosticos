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

  Future<List<Diagnostico>> getdiagnosticos() async {
    final url = _url + '/tests';

    return await _procesarRespuesta(url);
  }

  Future<List<Diagnostico>> _procesarRespuesta(String url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final diagnosticos = new Diagnosticos.fromJsonList(decodedData['items']);
    return diagnosticos.items;
  }
}
