import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../data/api_response.dart';
import '../../model/user_model.dart';
import '../../repository/user_data_repository/user_data_repository.dart';
import '../../resource/routes_name.dart';

class UserDataViewModel with ChangeNotifier {
  final UserDataRepository _myRepo = UserDataRepository();

  ApiResponse<UserModel> userData = ApiResponse.loading();

  UserModel? get currentUser => userData.data;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  void setUser(ApiResponse<UserModel> response) {
    userData = response;
    Future.microtask(() => notifyListeners());
  }

  Future<void> getUser(BuildContext context) async {
    setLoading(true);
    setUser(ApiResponse.loading());
    try {
      UserModel user = await _myRepo.getUser(context);
      if (kDebugMode) {
        print('User data: ${user.toJson()}');
      }
      setUser(ApiResponse.completed(user));
    } catch (e) {
      Navigator.pushReplacementNamed(context, RoutesName.login);
      setUser(ApiResponse.error(e.toString()));
    } finally {
      setLoading(false);
    }
  }


}
