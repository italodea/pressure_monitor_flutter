import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<String> login(String email, String password) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'POST', Uri.parse("${dotenv.env['API_URL']}/api/auth/login"));
      request.body = json.encode({"email": email, "password": password});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var body = jsonDecode(await response.stream.bytesToString());
        return body['accessToken'];
      } else if (response.statusCode == 401) {
        throw Exception('Email ou senha inválidos');
      }
      return '';
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Erro ao se conectar com o servidor');
      }
      rethrow;
    }
  }

  Future<String> loginGoogle(String name, String email, String googleId) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse("${dotenv.env['API_URL']}/api/auth/login-firebase"));

    request.body =
        json.encode({"firebaseToken": googleId, "name": name, "email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = jsonDecode(await response.stream.bytesToString());
      return body['accessToken'];
    }
    return "";
  }

  Future<String> register(String name, String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST', Uri.parse("${dotenv.env['API_URL']}/api/auth/register"));

    request.body =
        json.encode({"name": name, "email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = jsonDecode(await response.stream.bytesToString());
      return body['accessToken'];
    }
    if(response.statusCode == 401) {
      throw Exception('Email já cadastrado');
    }
    return "";
  }
}
