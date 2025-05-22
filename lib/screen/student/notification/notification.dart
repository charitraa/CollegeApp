import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/screen/student/notification/widgets/notificatin_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Notification",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 18,
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4B88C5),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
            Tab(text: 'Read'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              // Handle menu action
              if (value == 'mark') {
                // Navigate to profile
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'mark',
                child: Text('Mark All as Read'),
              ),
            ],
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(),
          _buildNotificationList(), // For demo, same list for Unread/Read
          _buildNotificationList(),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView(
      children: [
        notificationCard(
          avatar: 'https://i.pravatar.cc/150?img=1',
          title: 'Call For organizers.',
          message:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero...',
          time: 'Last Wednesday at 9:42 AM',
        ),
        notificationCard(
          avatar: 'https://i.pravatar.cc/150?img=2',
          title: 'Call For organizers.',
          message:
              'Nunc vulputate libero et velit interdum, ac aliquet odio mattis...',
          time: 'Last Wednesday at 9:42 AM',
          quoted: true,
        ),
        notificationCard(
          avatar: 'https://i.pravatar.cc/150?img=3',
          title: 'Student Support attached a file to Notice.',
          message: '📄 Sports Week.fig   2mb',
          time: 'Last Wednesday at 9:42 AM',
        ),
        notificationCard(
          avatar: 'https://i.pravatar.cc/150?img=4',
          title: 'Charitra Shrestha commented on Minal Git Hub',
          message:
              '“Oh, I finished de-bugging the phones, but the system’s compiling for eighteen minutes...',
          time: 'Last Wednesday at 9:42 AM',
        ),
        notificationCard(
          avatar: 'https://i.pravatar.cc/150?img=5',
          title: 'Tara GC commented on Charitra Shrestha SOC2 report',
          message: '',
          time: 'Last Wednesday at 9:42 AM',
        ),
      ],
    );
  }
}
