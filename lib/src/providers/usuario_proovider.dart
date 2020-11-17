import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {

  Future<Map<String, dynamic>> login( String email, String password) async {

    final authData = {
      'email'    : email,
      'password' : password,
    };

    final resp = await http.post(
      'https://tb-prediction-api.azurewebsites.net/api//usuarios/login',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      
      // _prefs.token = decodedResp['idToken'];

      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }

  }

}