import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pressure_monitor_flutter/service/LocalData/local_data.dart';

class PressureApi {
  LocalData localData = LocalData();

  Future<String> getPressures() async {
    String? token = await localData.getToken();
    var headers = {
      'Authorization': "Bearer $token",
    };
    var request = http.Request(
      'GET',
      Uri.parse(
        "${dotenv.env['API_URL']}/pressure",
      ),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else if (response.statusCode == 401) {
      throw Exception('Token inválido');
    } else {
      throw Exception('Erro ao buscar pressões');
    }
  }

  Future<String> createPressure(int sis, int dia) async {
    try {
      String? token = await localData.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      };
      var request = http.Request(
        'POST',
        Uri.parse(
          "${dotenv.env['API_URL']}/pressure",
        ),
      );
      request.body = json.encode({"systole": sis, "diastole": dia});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        return await response.stream.bytesToString();
      } else if (response.statusCode == 401) {
        throw Exception('Token inválido, faça login novamente');
      } else {
        throw Exception('Erro ao cadastrar pressão');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Erro ao se conectar com o servidor');
      }
      rethrow;
    }
  }
}
