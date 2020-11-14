import 'package:flutter/material.dart';
import 'package:app_diagnosticos/src/providers/login_provider.dart';

class LoginPage extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SafeArea(
                child: Container(
                  height: 90.0,
                ),
              ),
              SizedBox(
                  height: 155.0,
                  child: Image(
                      image: AssetImage("assets/images/logo.jpeg"),
                      height: 50.0,
                      fit: BoxFit.fitWidth)),
              SizedBox(height: 45.0),
              TextField(
                controller: _usernameController,
                obscureText: false,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Correo",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              // Divider(),
              SizedBox(height: 25.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: style,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Contraseña",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
              // Divider(),
              SizedBox(
                height: 35.0,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xff01A0C7),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;

                    if (username == "" || password == "")
                      displayDialog(
                          context, "Error", "Ingrese los datos de sesion");
                    else {
                      LoginProvider provider = new LoginProvider();
                      var result = await provider.login(username, password);
                      if (result != null) {
                        Navigator.pushNamed(context, 'examen');
                      } else {
                        displayDialog(
                            context, "Error", "Correo o cantrseña incorrectos");
                      }
                    }
                  },
                  child: Text("Ingresar",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
}
