import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lbef/widgets/no_internet_screen.dart';

class NoInternetWrapper extends StatefulWidget {
  final Widget child;

  const NoInternetWrapper({super.key, required this.child});

  @override
  State<NoInternetWrapper> createState() => _NoInternetWrapperState();
}

class _NoInternetWrapperState extends State<NoInternetWrapper> {
  late Stream<ConnectivityResult> _connectivityStream;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _checkConnection(); // Initial check
    _connectivityStream.listen((_) => _checkConnection());
  }

  void _checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (mounted) {
      setState(() {
        _hasInternet = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _hasInternet ? widget.child : const NoInternetScreen();
  }
}
