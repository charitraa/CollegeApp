import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/screen/student/application/file_application.dart';
import 'package:lbef/screen/student/application/widgets/view_application.dart';
import 'package:lbef/screen/student/daily_class_report/shimmer/class_card_shimmer.dart';
import 'package:lbef/screen/student/application/widgets/application_widget.dart';
import 'package:lbef/view_model/application_files/application_view_model.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../utils/navigate_to.dart';
import '../daily_class_report/reports/reports.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late ScrollController _scrollController;
  var logger=Logger();
  bool isLoad = false;


  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent &&
        !isLoad) {
      loadMore();
    }
  }

  void fetch() async {
    await Provider.of<ApplicationViewModel>(context, listen: false)
        .fetch(context);
  }

  Future<void> loadMore() async {
    if (isLoad) return;
    setState(() => isLoad = true);
    try {
      await Provider.of<ApplicationViewModel>(context, listen: false)
          .loadMore(context);
    } catch (e) {
      if (kDebugMode) logger.d("Error loading more: $e");
    } finally {
      setState(() => isLoad = false);
    }
  }
  bool _isLoading = true;
  List<Map<String, String>> applications = [];

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
    // fetch();
    _loadDummyData();
  }

  void _loadDummyData() async {
    applications = [
      {
        'title': 'Leave Application',
        'subBody': 'Request for 3 days of medical leave.',
        'status': 'Pending',
        'email': 'john.doe@student.edu',
        'subject': 'Medical Leave - Fever',
        'department': 'Academic Department',
        'description':
            'I am suffering from a high fever and have been advised bed rest. I would like to apply for leave from 10th to 12th May.',
        'attachment': 'leave_certificate.pdf',
      },
      {
        'title': 'Exam Retake Request',
        'subBody': 'Applied to retake the missed exam due to illness.',
        'status': 'Approved',
        'email': 'sara.lee@student.edu',
        'subject': 'Missed Midterm - Request Retake',
        'department': 'Examination Cell',
        'description':
            'Due to severe flu, I missed my midterm on Data Structures. Kindly approve my request for a retake next week.',
        'attachment': 'medical_report.jpg',
      },
      {
        'title': 'Fee Concession',
        'subBody': 'Seeking concession due to financial difficulty.',
        'status': 'Rejected',
        'email': 'mohit.kumar@student.edu',
        'subject': 'Fee Waiver Request',
        'department': 'Finance Department',
        'description':
            'I am facing financial hardship at home. I humbly request a 30% concession on this semester\'s fees.',
        'attachment': 'income_certificate.pdf',
      },
      {
        'title': 'Hostel Transfer',
        'subBody': 'Request to transfer to North Block due to better internet.',
        'status': 'Pending',
        'email': 'anish.thapa@student.edu',
        'subject': 'Hostel Change Request',
        'department': 'Student Affairs',
        'description':
            'I am currently staying in South Block, but due to poor internet, I’m requesting a transfer to North Block.',
        'attachment': 'speed_test_results.png',
      },
      {
        'title': 'ID Card Reissue',
        'subBody': 'Lost ID card, requesting reissue.',
        'status': 'Approved',
        'email': 'rina.sharma@student.edu',
        'subject': 'Lost ID Card - Reissue Request',
        'department': 'Admin Office',
        'description':
            'I lost my student ID card while commuting. Please issue a new one at the earliest.',
        'attachment': 'fir_report.pdf',
      },
    ];

    setState(() {
      _isLoading = false;
    });
  }

  Color _getIconColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.blue;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Applications",
          style: TextStyle(fontFamily: 'poppins', fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                SlideRightRoute(page: const FileApplication()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                children: [
                  Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {

                    },
                    child: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: _isLoading
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: ClassCardShimmer(),
                ),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: applications.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final application = applications[index];
                  final iconColor = _getIconColor(application['status']!);

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        SlideRightRoute(
                          page: ViewApplicationPage(
                            applicationData: application,
                          ),
                        ),
                      );
                    },
                    child: ApplicationWidget(
                      iconColor: iconColor,
                      textColor: Colors.white,
                      btnColor: iconColor,
                      status: application['status']!,
                      title: application['title']!,
                      subBody: application['subBody']!,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
