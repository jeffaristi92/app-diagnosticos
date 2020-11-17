import 'package:app_diagnosticos/src/models/diagnostico_model.dart';
import 'package:flutter/material.dart';

import 'package:app_diagnosticos/src/providers/diagnosticos_provider.dart';

class DiagnosticosPage extends StatelessWidget {
  final peliculasProvider = new DiagnosticosProvider();
  final diganosticosProvider = new DiagnosticosProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getdiagnosticos();

    return Scaffold(
        appBar: AppBar(
          title: Text('Diagnosticos'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, 'examen');
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // _header(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _header() {
    return Container(
      child: Text('Diagnosticos'),
    );
  }

  Widget _footer(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
        future: diganosticosProvider.getdiagnosticos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Diagnostico>> snapshot) {
          if (snapshot.hasData) {
            return Container(
                height: _screenSize.height * 0.8,
                child: ListView(
                  children: _diagnosticos(context, snapshot.data),
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  _diagnosticos(BuildContext context, List<Diagnostico> diagnosticos) {
    List<ListTile> lista = [];
    for (var item in diagnosticos) {
      lista.add(_diagnostico(context, item));
    }
    print(lista.length);
    return lista;
  }

  Widget _diagnostico(BuildContext context, Diagnostico diagnostico) {
    print(diagnostico.paciente);
    String nombre = "Anonimo";
    if (diagnostico.paciente != null) {
      nombre = diagnostico.paciente;
    }
    return ListTile(
      leading: Icon(Icons.assessment),
      title: Text(nombre),
      subtitle: Text(diagnostico.fecha.toString()),
      onTap: () {
        //close(context, null);
        //Navigator.pushNamed(context, 'detalle', arguments: diagnostico);
      },
    );
  }

  siguientePagina() {}
}
