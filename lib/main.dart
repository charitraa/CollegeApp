import 'package:flutter/material.dart';
import 'package:lbef/resource/routes.dart';
import 'package:lbef/resource/routes_name.dart';
import 'package:lbef/screen/auth/login_page.dart';
import 'package:lbef/screen/navbar/student_navbar.dart';
import 'package:lbef/screen/student/class_routines/class_routines.dart';
import 'package:lbef/screen/student/dashboard/dashboard.dart';
import 'package:lbef/view_model/user_view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: Builder(
        builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: MaterialApp(
              title: 'LBEF',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
                fontFamily: 'Poppins',
              ),
              debugShowCheckedModeBanner: false,
              // initialRoute: RoutesName.student,
              // onGenerateRoute: Routes.generateRoute,
              home:  StudentNavbar(index: 2,),

            ),
          );
        },
      ),
    );
  }
}
