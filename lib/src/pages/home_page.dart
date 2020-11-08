import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosticos App'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Realizar examen'),
              leading: Icon(Icons.assignment),
              onTap: () {
                Navigator.pushNamed(context, 'examen');
              },
            )
          ],
        ),
      ),
    );
  }
}
