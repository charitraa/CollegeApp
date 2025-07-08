import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
// import 'package:lbef/screen/auth/unauthorised.dart';
import 'package:lbef/screen/student/daily_class_report/daily_class_report.dart';
// import 'package:lbef/screen/student/daily_class_report/reports/reports.dart';
import 'package:lbef/screen/student/dashboard/dashboard.dart';
import 'package:lbef/screen/student/profile/profile.dart';
import 'package:lbef/screen/student/student_fees/student_fees.dart';
import 'package:provider/provider.dart';

import '../../view_model/user_view_model/current_user_model.dart';
import '../student/application/application.dart';

class StudentNavbar extends StatefulWidget {
  final int? index;
  const StudentNavbar({super.key, this.index = 0});

  @override
  State<StudentNavbar> createState() => _StudentNavbarState();
}

class _StudentNavbarState extends State<StudentNavbar> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    fetch();
    _selectedIndex = widget.index ?? 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void fetch() async {
    await Provider.of<UserDataViewModel>(context, listen: false)
        .getUser(context);
  }
  final List<Widget> _pages = const [
    Dashboard(),
    DailyClassReport(),
    Application(),
    StudentFees(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 70,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        items: [
          CurvedNavigationBarItem(
            child: SizedBox(
              height: 35,
              width: 35,
              child: Icon(
                Icons.dashboard,
                color: _selectedIndex == 0 ? Colors.blue : Colors.black,
                size: 24,
              ),
            ),
            label: 'Home',
            labelStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
          CurvedNavigationBarItem(
            child: SizedBox(
              height: 35,
              width: 35,
              child: Icon(
                Icons.assignment_outlined,
                color: _selectedIndex == 1 ? Colors.blue : Colors.black,
                size: 24,
              ),
            ),
            label: 'DCR',
            labelStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
          CurvedNavigationBarItem(
            child: SizedBox(
              height: 35,
              width: 35,
              child: Icon(
                Icons.outgoing_mail,
                color: _selectedIndex == 2 ? Colors.blue : Colors.black,
                size: 25,
              ),
            ),
            label: 'Application',
            labelStyle: const TextStyle(fontSize: 12, height: 1.2),
          ),
          CurvedNavigationBarItem(
            child: SizedBox(
              height: 35,
              width: 35,
              child: Icon(
                Icons.payments_outlined,
                color: _selectedIndex == 3 ? Colors.blue : Colors.black,
                size: 25,
              ),
            ),
            label: 'Fees',
            labelStyle: const TextStyle(fontSize: 12, height: 1.2),
          ),
          CurvedNavigationBarItem(
            child: SizedBox(
              height: 35,
              width: 35,
              child: Icon(
                Icons.person_outline,
                color: _selectedIndex == 4 ? Colors.blue : Colors.black,
                size: 25,
              ),
            ),
            label: 'Profile',
            labelStyle: const TextStyle(fontSize: 12, height: 1.2),
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
