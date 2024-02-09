import 'package:firebase_auth/firebase_auth.dart';
import 'package:pressure_monitor_flutter/api/auth_api.dart';
import 'package:pressure_monitor_flutter/service/LocalData/local_data.dart';

class LoginService {
  AuthApi api = AuthApi();
  LocalData localData = LocalData();
  Future<bool> login(String email, String password) async {
    String token = await api.login(email, password);
    if (token != '') {
      await localData.saveToken(token);
      return true;
    }
    return false;
  }

  Future<bool> loginGoogle(User user) async {
    if(user.email == null || user.displayName == null) {
      return false;
    }
    String token = await api.loginGoogle(user.displayName!, user.email!, user.uid);
    if (token != '') {
      await localData.saveToken(token);
      return true;
    }
    return false;
  }
}
