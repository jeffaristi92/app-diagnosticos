import 'package:app_diagnosticos/src/pages/diagnostigos_page.dart';
import 'package:app_diagnosticos/src/pages/examen_page.dart';
import 'package:app_diagnosticos/src/pages/home_page.dart';
import 'package:app_diagnosticos/src/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(DiagnosticosApp());

class DiagnosticosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diagnosticos App',
      initialRoute: 'diagnosticos',
      routes: {
        'home': (BuildContext context) => LoginPage(),
        'examen': (BuildContext context) => ExamenPage(),
        'diagnosticos': (BuildContext context) => DiagnosticosPage(),
      },
      theme: ThemeData(primaryColor: Colors.blue),
    );
  }
}
