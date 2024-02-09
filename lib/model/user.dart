import 'package:pressure_monitor_flutter/model/token_details.dart';

class User {
  int id;
  String name;
  String email;
  TokenDetails token;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.token});
}
