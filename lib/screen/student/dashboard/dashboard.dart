import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/screen/navbar/student_navbar.dart';
import 'package:lbef/screen/student/dashboard/widgets/dashboard_head.dart';
import 'package:lbef/screen/student/notice/notice.dart';

import '../../../utils/navigate_to.dart';
import '../../../widgets/no_data/no_data_widget.dart';
import '../notice/view_notice_board.dart';
import '../notice/widgets/notice_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, String>> notices = [
    {
      'published': '2025-05-18',
      'subBody':
          'Urgent: Class relocation notice.Student election results announced.',
      'body':
          'Dear Students, please note that all classes scheduled in Block B will be temporarily shifted to Block D due to ongoing maintenance. Thank you for your cooperation. Regards, Admin'
    },
    {
      'published': '2025-05-16',
      'subBody': 'Library closure this weekend.',
      'body':
          'The college library will be closed on Saturday and Sunday (May 17–18) for inventory and system upgrades. Please issue or return books accordingly by Friday. - Library Management'
    },
    {
      'published': '2025-05-15',
      'subBody': 'Submission deadline extended.',
      'body':
          'The deadline for submitting your Capstone Project Proposal has been extended to May 22, 2025. No further extensions will be granted. - Academic Affairs'
    },
    {
      'published': '2025-05-14',
      'subBody': 'Seminar on AI Ethics tomorrow.',
      'body':
          'We are hosting a seminar on AI Ethics and Privacy on May 15 at the Main Auditorium from 10 AM to 12 PM. All IT students are encouraged to attend. - IT Department'
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            const DashboardHead(

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upcoming Events',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "View All",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: BuildNoData(size,
                  "No upcoming events at the moment. Stay tuned for future updates!",
                  Icons.event_busy
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Notices',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            SlideRightRoute(
                              page: const NoticeBoard(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "View All",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 0,
                    runSpacing: 14,
                    children: notices.take(3).map((application) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            SlideRightRoute(
                              page: ViewNoticeBoard(noticeData: application),
                            ),
                          );
                        },
                        child: NoticeWidget(
                          published: application['published'] ?? '',
                          body: application['body'] ?? '',
                          subBody: application['subBody'] ?? '',
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
