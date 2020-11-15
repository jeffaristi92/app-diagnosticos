import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginProvider {
  String _url = "https://tb-prediction-api.azurewebsites.net/api";

  Future<String> login(String email, String password) async {
    final msg = jsonEncode({"email": email, "password": password});

    final resp = await http.post(_url + '/usuarios/login',
        body: msg, headers: {"Content-Type": "application/json"});

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      String token = decodedData['token'];
      return token;
    }
    return null;
  }
}
