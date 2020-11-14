import 'package:flutter/material.dart';

class DiagnosticosPage extends StatefulWidget {
  @override
  _DiagnosticosPageState createState() => _DiagnosticosPageState();
}

class _DiagnosticosPageState extends State<DiagnosticosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _listadoDaignosticos(),
      ),
    );
  }

  List<Widget> _listadoDaignosticos() {
    List<Widget> diagnosticos = new List<Widget>();

    diagnosticos.add(ListTile(
      title: Text('Diagnosticos'),
      leading: Icon(Icons.assignment),
      onTap: () {
        Navigator.pushNamed(context, 'examen');
      },
    ));

    return diagnosticos;
  }
}
