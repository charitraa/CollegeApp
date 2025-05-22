import 'package:flutter/material.dart';
import 'package:lbef/screen/student/profile/changePassword/change_password.dart';
import 'package:lbef/screen/student/profile/event/event.dart';
import 'package:lbef/screen/student/profile/teachers/teachers.dart';
import 'package:lbef/screen/student/profile/widgets/build_list_tile.dart';
import 'package:lbef/screen/student/profile/widgets/info_box.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(fontFamily: 'poppins'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/profile.png'), // replace with your asset
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Charitra Shrestha',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  infoBox('78%', 'Over all\nAttendance\nin this sem'),
                  infoBox('20K', 'Amount of\nFees\npending in this sem'),
                ],
              ),

              const SizedBox(height: 20),

              // List Items
              buildListTile(Icons.event, 'Events', () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const Event(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
              buildListTile(Icons.lock, 'Change Password', () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ChangePassword(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
              buildListTile(Icons.picture_as_pdf, 'Print Admit Card', () {}),
              buildListTile(Icons.people, 'Teachers', () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const TeachersPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
              buildListTile(Icons.info, 'About', () {}),
              buildListTile(Icons.help_outline, 'Help', () {}),
              buildListTile(Icons.call, 'Contact', () {}),
              buildListTile(Icons.logout, 'Sign Out', () {}),
            ],
          ),
        ),
      ),
    );
  }
}
