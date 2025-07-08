import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    var logger=Logger();
    if (kDebugMode) {
      logger.d(user.token);
    }
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool sessionSaved = await sp.setString('token', user.token.toString());
    logger.d(sessionSaved);

    return sessionSaved;
  }


  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    notifyListeners();
    return true;
  }

  Future<bool> isAuthenticated() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('token') != null;
  }
}