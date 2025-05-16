import 'package:flutter/material.dart';
import 'package:lbef/screen/student/daily_class_report/reports/stacked_reports.dart';
import 'package:lbef/screen/student/daily_class_report/widgets/attendence_bar.dart';
import 'package:lbef/screen/student/daily_class_report/widgets/individual_card_head.dart';
import '../../../../resource/colors.dart';

class Reports extends StatefulWidget {
  final String image, facultyName, subject, code, section;

  const Reports({
    super.key,
    required this.image,
    required this.facultyName,
    required this.code,
    required this.section,
    required this.subject,
  });

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List<Map<String, String>> classReports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateApiLoad();
  }

  void _simulateApiLoad() async {
    setState(() {
      classReports = [
        {
          "date": "2025-03-23",
          "roomHead": "Room Number",
          "roomNo": "A-103",
          "taughtHead": "Taught in Class",
          "taught": "Deep Analysis on Literature Review",
          "assignmentHead": "Assignment",
          "assignment":
              "Do 16 literature reviews and start writing proposal with referencing",
          "activityHead": "Activity",
          "activity": "Review two sample thesis from seniors",
          "AttendenceHead": "Attendance",
          "attendence": "Absent"
        },
        {
          "date": "2025-03-25",
          "roomHead": "Room Number",
          "roomNo": "B-201",
          "taughtHead": "Taught in Class",
          "taught": "Introduction to Research Methodologies",
          "assignmentHead": "Assignment",
          "assignment": "Summarize qualitative vs. quantitative methods",
          "activityHead": "Activity",
          "activity": "Group discussion on research topics",
          "AttendenceHead": "Attendance",
          "attendence": "Present"
        },
        {
          "date": "2025-03-27",
          "roomHead": "Room Number",
          "roomNo": "C-305",
          "taughtHead": "Taught in Class",
          "taught": "Research Problem Identification",
          "assignmentHead": "Assignment",
          "assignment": "Identify 3 potential research problems",
          "activityHead": "Activity",
          "activity": "Brainstorming session in teams",
          "AttendenceHead": "Attendance",
          "attendence": "Present"
        },
        {
          "date": "2025-03-30",
          "roomHead": "Room Number",
          "roomNo": "A-104",
          "taughtHead": "Taught in Class",
          "taught": "Hypothesis and Objectives",
          "assignmentHead": "Assignment",
          "assignment": "Write 3 hypotheses related to your topic",
          "activityHead": "Activity",
          "activity": "Peer review of research objectives",
          "AttendenceHead": "Attendance",
          "attendence": "Present"
        },
        {
          "date": "2025-04-01",
          "roomHead": "Room Number",
          "roomNo": "B-102",
          "taughtHead": "Taught in Class",
          "taught": "Referencing Styles and Plagiarism",
          "assignmentHead": "Assignment",
          "assignment": "Create a reference list in APA style",
          "activityHead": "Activity",
          "activity": "Citation scavenger hunt",
          "AttendenceHead": "Attendance",
          "attendence": "Absent"
        },
        {
          "date": "2025-04-03",
          "roomHead": "Room Number",
          "roomNo": "C-301",
          "taughtHead": "Taught in Class",
          "taught": "Proposal Writing Format",
          "assignmentHead": "Assignment",
          "assignment": "Draft proposal outline",
          "activityHead": "Activity",
          "activity": "Review a senior’s accepted proposal",
          "AttendenceHead": "Attendance",
          "attendence": "Present"
        },
        {
          "date": "2025-04-05",
          "roomHead": "Room Number",
          "roomNo": "A-201",
          "taughtHead": "Taught in Class",
          "taught": "Sampling Techniques",
          "assignmentHead": "Assignment",
          "assignment": "Write about 5 sampling methods",
          "activityHead": "Activity",
          "activity": "Analyze sampling from a published paper",
          "AttendenceHead": "Attendance",
          "attendence": "Present"
        },
        {
          "date": "2025-04-08",
          "roomHead": "Room Number",
          "roomNo": "B-303",
          "taughtHead": "Taught in Class",
          "taught": "Survey and Questionnaire Design",
          "assignmentHead": "Assignment",
          "assignment": "Design a 10-question survey on your topic",
          "activityHead": "Activity",
          "activity": "Mock survey in pairs",
          "AttendenceHead": "Attendance",
          "attendence": "Absent"
        },
        {
          "date": "2025-04-10",
          "roomHead": "Room Number",
          "roomNo": "C-202",
          "taughtHead": "Taught in Class",
          "taught": "Ethical Considerations in Research",
          "assignmentHead": "Assignment",
          "assignment": "List 5 ethical concerns in your field",
          "activityHead": "Activity",
          "activity": "Case study: Ethics in real research",
          "AttendenceHead": "Attendance",
          "attendence": "Present"
        },
        {
          "date": "2025-04-12",
          "roomHead": "Room Number",
          "roomNo": "A-107",
          "taughtHead": "Taught in Class",
          "taught": "Final Proposal Review Session",
          "assignmentHead": "Assignment",
          "assignment": "Submit final version of your proposal",
          "activityHead": "Activity",
          "activity": "Present proposal draft to class",
          "AttendenceHead": "Attendance",
          "attendence": "Present"
        }
      ];
      isLoading = false;
    });
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
          onPressed: () => Navigator.pop(context),
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
        child: Column(
          children: [
            IndividualCardHead(
              image: widget.image,
              tutor: widget.facultyName,
              subject: widget.subject,
              code: widget.code,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'View reports from the last 30 classes.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Section - ${widget.section}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const AttendanceBar(percentage: 75),
            const SizedBox(height: 15),

            // MAIN CONTENT AREA
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : classReports.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.report_gmailerrorred_outlined,
                                  size: 60, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                "No Daily Class Reports",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: classReports.length,
                          itemBuilder: (context, index) {
                            final report = classReports[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: StackedReports(
                                date: report['date'] ?? '',
                                time: "10:00 AM",
                                room: report['roomHead'] ?? '',
                                roomNo: report['roomNo'] ?? '',
                                taught: report['taughtHead'] ?? '',
                                taughtInClass: report['taught'] ?? '',
                                assignment: report['assignmentHead'] ?? '',
                                assignmentInClass: report['assignment'] ?? '',
                                activity: report['activityHead'] ?? '',
                                task: report['activity'] ?? '',
                                attendence: report['AttendenceHead'] ?? '',
                                attendenceScore: report['attendence'] ?? '',
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
