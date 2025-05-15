import 'package:flutter/material.dart';
import 'package:lbef/screen/student/dashboard/widgets/dashboard_head.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashboardHead(userName: 'Charitra Shrestha',),
          ],
        ),
      ),
    );
  }
}
