import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lbef/model/user_model.dart';
import 'package:logger/logger.dart';
import '../data/api_response.dart';
import '../data/status.dart';
import '../repository/authentication_repo/auth_repository.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _myrepo = AuthRepository();
var logger=Logger();
  ApiResponse<UserModel> userData = ApiResponse.loading();
  UserModel? get currentUser => userData.data;
  bool _isLoading = false;
  String _role = '';
  String get role => _role;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  void setUser(ApiResponse<UserModel> response) {
    userData = response;
    Future.microtask(() => notifyListeners());
  }

  Future login(dynamic body, BuildContext context) async {
    setLoading(true);

    try {
      final response = await _myrepo.login(body, context);
      if (response.status == Status.ERROR) {
        Utils.flushBarErrorMessage(
            response.message ?? "An error occurred", context);
      } else {
        // if (response.data.emailStatus == 0) {
        //   Navigator.of(context).push(
        //     PageRouteBuilder(
        //       pageBuilder: (context, animation, secondaryAnimation) =>
        //           EmailVerification(
        //             uid: response.data.userId.toString(),
        //             pass: body['password'],
        //             email: response.data.email,
        //           ),
        //       transitionsBuilder:
        //           (context, animation, secondaryAnimation, child) {
        //         const begin = Offset(1.0, 0.0);
        //         const end = Offset.zero;
        //         const curve = Curves.easeInOut;
        //         var tween = Tween(begin: begin, end: end)
        //             .chain(CurveTween(curve: curve));
        //         return SlideTransition(
        //             position: animation.drive(tween), child: child);
        //       },
        //     ),
        //   );
        //   return; // Prevents further execution
        // }

        Utils.flushBarSuccessMessage(
            "User Logged in successfully!!!!", context);
        final String userRole = response.data.parentBody ?? "Unknown";
        setLoading(false);


logger.d("User ROLE $userRole");
        //   switch (userRole) {
        //     case 'superadmin':
        //       Navigator.pushReplacementNamed(context, RoutesName.admin);
        //       break;
        //     case 'admin':
        //       Navigator.pushReplacementNamed(context, RoutesName.admin);
        //       break;
        //     case 'vendor':
        //       Navigator.pushReplacementNamed(context, RoutesName.vendor);
        //       break;
        //     case 'customer':
        //       Navigator.pushReplacementNamed(context, RoutesName.user);
        //       break;
        //     default:
        //       Utils.flushBarErrorMessage("Unknown role", context);
        //   }
        // }
      }
    } catch (error) {
      Utils.flushBarErrorMessage('$error', context);
      setLoading(false);
    }
  }
}
