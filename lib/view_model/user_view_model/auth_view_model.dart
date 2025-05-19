import 'package:flutter/cupertino.dart';
import 'package:lbef/model/user_model.dart';
import 'package:lbef/view_model/user_view_model/user_view_model.dart';
import 'package:logger/logger.dart';

import '../../data/api_response.dart';
import '../../data/status.dart';
import '../../repository/authentication_repo/auth_repository.dart';
import '../../resource/routes_name.dart';
import '../../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _myrepo = AuthRepository();
  final Logger logger = Logger();

  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _role = '';
  String get role => _role;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUser(ApiResponse<UserModel> response) {
    userData = response;
    notifyListeners();
  }

  Future<void> login(dynamic body, BuildContext context) async {
    setLoading(true);
    try {
      final response = await _myrepo.login(body, context);

      if (response.status == Status.ERROR) {
        Utils.flushBarErrorMessage(
          response.message ?? "An error occurred",
          context,
        );
        setLoading(false);
        return;
      }
      Utils.flushBarSuccessMessage("User Logged in successfully!", context);
      final String userRole = response.data.user.parentTable ?? "Unknown";
      _role = userRole;
      setUser(ApiResponse.completed(response.data));
      setLoading(false);
      switch (userRole) {
        case 'employee':
          Navigator.pushReplacementNamed(context, RoutesName.student);
          break;
        case 'admin':
        case 'student':
          Navigator.pushReplacementNamed(context, RoutesName.student);
          break;
        default:
          Utils.flushBarErrorMessage("Unknown role", context);
      }
    } catch (error) {
      logger.e("Login Error", error: error);
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoading(false);
    }
  }
  Future<void> logout(BuildContext context) async {
    setLoading(true);
    try {
      final response = await _myrepo.logout(context);
      if (response.status == Status.COMPLETED) {
        Utils.flushBarSuccessMessage("User Logged out Successfully!", context);
        await UserViewModel().remove();
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        Utils.flushBarErrorMessage(
            response.message ?? "An error occurred", context);
      }
    } catch (e) {
      Utils.flushBarErrorMessage("Error: $e", context);
    } finally {
      setLoading(false);
    }
  }
}
