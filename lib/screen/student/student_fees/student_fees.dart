import 'package:flutter/material.dart';
import 'package:lbef/screen/student/student_fees/tab_content/balance.dart';
import 'package:lbef/screen/student/student_fees/tab_content/receipts.dart';
import 'package:lbef/screen/student/student_fees/tab_content/statements.dart';

class StudentFees extends StatelessWidget {
  const StudentFees({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "College Fees",
            style: TextStyle(
              fontFamily: 'poppins',
            ),
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
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Balance'),
              Tab(text: 'Receipts'),
              Tab(text: 'Statement'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [Balance(), Receipts(), Statements()],
        ),
      ),
    );
  }
}
