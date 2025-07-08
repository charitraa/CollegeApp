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
      final response = await _myrepo.login(body, context: context);
      if (response.status == Status.ERROR) {
        setUser(ApiResponse.error(response.message ?? "Unexpected error"));
        Utils.flushBarErrorMessage(response.message ?? "Unexpected error", context);
        return;
      }
      setUser(ApiResponse.completed(response.data));
      Utils.flushBarSuccessMessage(
          response.message ?? "User Logged in successfully!", context);
      Navigator.pushReplacementNamed(context, RoutesName.student);
    } catch (error) {
      setUser(ApiResponse.error(error.toString()));
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoading(false);
    }
  }
  Future<void> logout(BuildContext context) async {
    setLoading(true);
    try {
      final response = await _myrepo.logout();
      if (response.status == Status.COMPLETED) {
        Utils.flushBarSuccessMessage(
            response.message ?? "User Logged out Successfully!", context);
        await UserViewModel().remove();
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        Utils.flushBarErrorMessage(
            response.message ?? "An error occurred", context);
      }
    } catch (error) {
      logger.e("Logout Error", error: error);
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoading(false);
    }
  }
}