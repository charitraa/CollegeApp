import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    if (kDebugMode) {
      print(user.token);
    }
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool sessionSaved = await sp.setString('token', user.token.toString());
    bool roleSaved = await sp.setString('role', user.user?.parentTable ?? '');
    bool emailSaved = await sp.setString('email', user.user?.email ?? '');
    return sessionSaved && roleSaved && emailSaved;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    final String? role = sp.getString('role');
    final String? email = sp.getString('email');

    return UserModel(
      token: token,
      user: User(
        parentTable: role,
        email: email,
      ),
    );
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    await sp.remove('role');
    await sp.remove('email');
    notifyListeners();
    return true;
  }

  Future<bool> isAuthenticated() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('token') != null;
  }

  Future<String?> getRole() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('role');
  }
}
