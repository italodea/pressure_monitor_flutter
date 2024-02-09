import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pressure_monitor_flutter/model/token_details.dart';
import 'package:pressure_monitor_flutter/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<User?> getUserFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      TokenDetails tokenDetails = TokenDetails(
          token: token, iat: decodedToken['iat'], exp: decodedToken['exp']);
      return User(
        id: decodedToken['id'],
        name: decodedToken['name'],
        email: decodedToken['email'],
        token: tokenDetails,
      );
    }
    return null;
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      return JwtDecoder.isExpired(token);
    }
    return true;
  }
}
