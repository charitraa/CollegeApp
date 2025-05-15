import 'package:flutter/material.dart';
import 'package:lbef/screen/student/daily_class_report/reports/stacked_reports.dart';
import 'package:lbef/screen/student/daily_class_report/widgets/attendence_bar.dart';
import 'package:lbef/screen/student/daily_class_report/widgets/individual_card_head.dart';

import '../../../../resource/colors.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});
  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily Report",
          style: TextStyle(fontFamily: 'poppins', fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 18,
        ),
        actions: const [
          Image(
            image: AssetImage('assets/images/lbef.png'),
            width: 56,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 14),
        ],
      ),
      body: Container(
        width: size.width,
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const IndividualCardHead(
                  image: 'assets/images/mountain.jpg',
                  tutor: "Nujan Shrestha",
                  subject: 'OBJECT ORIENTED PROGRAMMING AND SOFTWARE ENGINEERING',
                  code: 'CIS6FGV8'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'View reports from the last 30 classes.',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const AttendanceBar(percentage: 75),
              const SizedBox(
                height: 15,
              ),
              StackedReports(),
              const SizedBox(
                height: 15,
              ),
              StackedReports(),
            ],
          ),
        ),
      ),
    );
  }
}
