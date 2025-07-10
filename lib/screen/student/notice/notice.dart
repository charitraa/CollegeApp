import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/screen/student/daily_class_report/shimmer/class_card_shimmer.dart';
import 'package:lbef/screen/student/notice/view_notice_board.dart';
import 'package:lbef/screen/student/notice/widgets/notice_widget.dart';
import 'package:lbef/view_model/notice_board/notice_board_view_model.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../utils/navigate_to.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  late ScrollController _scrollController;
  var logger = Logger();
  bool isLoad = false;
  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoad) {
      loadMore();
    }
  }

  void fetch() async {
    await Provider.of<NoticeBoardViewModel>(context, listen: false)
        .fetch(context);
  }

  Future<void> loadMore() async {
    if (isLoad) return;
    setState(() => isLoad = true);
    try {
      await Provider.of<NoticeBoardViewModel>(context, listen: false)
          .loadMore(context);
    } catch (e) {
      if (kDebugMode) logger.d("Error loading more: $e");
    } finally {
      setState(() => isLoad = false);
    }
  }

  bool _isLoading = true;
  List<Map<String, String>> notices = [];

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
    // fetch();
    _loadDummyData();
  }

  void _loadDummyData() async {
    notices = [
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
      {
        'published': '2025-05-13',
        'subBody': 'Medical leave approved.',
        'body':
            'Dear Minal Pariyar, your medical leave request from May 10 to May 12 has been approved. Please submit your medical documents to the office. Kind Regards, Student Support'
      },
      {
        'published': '2025-05-12',
        'subBody': 'Important: Exam schedule released.',
        'body':
            'Final exam schedules for all departments have been released. Please check the notice board or visit the student portal. - Examination Department'
      },
      {
        'published': '2025-05-10',
        'subBody': 'Student election results announced.',
        'body':
            'The results for the 2025 Student Council Elections have been declared. Visit the admin office or student portal for details. - Student Affairs'
      },
      {
        'published': '2025-05-08',
        'subBody': 'Project Viva schedule update.',
        'body':
            'All students of BSc CSIT final year are informed that the viva schedule has been updated. Check your departmental group or contact your project guide.'
      },
      {
        'published': '2025-05-07',
        'subBody': 'Invitation to Hackathon 2025.',
        'body':
            'Registrations are open for Hackathon 2025, happening on May 20–21. Cash prizes up to Rs. 50,000! Register via the Events tab. - Events Club'
      },
      {
        'published': '2025-05-05',
        'subBody': 'Attendance warning: Below 75%.',
        'body':
            'Dear Student, you have been issued a first warning for falling below the required 75% attendance in three subjects. Attend your classes regularly to avoid penalties. - Student Affairs'
      },
    ];

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notice Board",
          style: TextStyle(fontFamily: 'poppins'),
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
            width: 70,
            height: 50,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 14),
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
                itemCount: notices.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final application = notices[index];

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
                },
              ),
      ),
    );
  }
}
