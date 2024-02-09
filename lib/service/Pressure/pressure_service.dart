import 'dart:convert';

import 'package:pressure_monitor_flutter/api/pressure_api.dart';
import 'package:pressure_monitor_flutter/model/pressure.dart';

class PressureService {
  PressureApi api = PressureApi();
  Future<List<Pressure>> getResumedPressureList() async {
    String source = await api.getPressures();
    List<dynamic> json = jsonDecode(source);
    json = json.reversed.toList();
    List<Pressure> response = [];
    for (var i = 0; i < (json.length < 10 ? json.length : 10); i++) {
      var e = json[i];
      response.add(
        Pressure(
            id: e['id'],
            systole: e['systole'],
            diastole: e['diastole'],
            updatedAt: e['updatedAt'],
            createdAt: e['createdAt']),
      );
    }

    return response;
  }

  Future<List<Pressure>> getPressureList() async {
    String source = await api.getPressures();
    List<dynamic> json = jsonDecode(source);
    json = json.reversed.toList();
    List<Pressure> response = [];
    for (var e in json) {
      response.add(
        Pressure(
            id: e['id'],
            systole: e['systole'],
            diastole: e['diastole'],
            updatedAt: e['updatedAt'],
            createdAt: e['createdAt']),
      );
    }

    return response;
  }

  Future<Pressure> createPressure(String sis, String dia) async {
    int sistole = int.parse(sis);
    int diastole = int.parse(dia);

    String source = await api.createPressure(sistole, diastole);
    var json = jsonDecode(source);

    return Pressure(
      id: json['id'],
      systole: json['systole'],
      diastole: json['diastole'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }
}
