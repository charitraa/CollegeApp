import 'package:flutter/material.dart';
import 'package:lbef/screen/student/profile/widgets/build_list_tile.dart';
import 'package:lbef/screen/student/profile/widgets/info_box.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage:
                    AssetImage('assets/profile.png'), // replace with your asset
              ),
              const SizedBox(height: 10),
              const Text(
                'Hi',
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                'Charitra Shrestha',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Attendance and Fee Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  infoBox('78%', 'Over all\nAttendance\nin this sem'),
                  infoBox('20K', 'Amount of\nFees\npending in this sem'),
                ],
              ),

              const SizedBox(height: 20),

              // List Items
              buildListTile(Icons.event, 'Events'),
              buildListTile(Icons.lock, 'Change Password'),
              buildListTile(Icons.picture_as_pdf, 'Print Admit Card'),
              buildListTile(Icons.people, 'Teachers'),
              buildListTile(Icons.info, 'About'),
              buildListTile(Icons.help_outline, 'Help'),
              buildListTile(Icons.call, 'Contact'),
              buildListTile(Icons.logout, 'Sign Out'),
            ],
          ),
        ),
      ),
    );
  }
}
