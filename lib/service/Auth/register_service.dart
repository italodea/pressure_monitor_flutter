import 'package:pressure_monitor_flutter/api/auth_api.dart';
import 'package:pressure_monitor_flutter/service/LocalData/local_data.dart';

class RegisterService {
  AuthApi api = AuthApi();
  LocalData localData = LocalData();

  Future<bool> register(String email, String password, String name) async {
    String token = await api.register(email, password, name);
    if (token != '') {
      await localData.saveToken(token);
      return true;
    }
    return false;
  }
}
