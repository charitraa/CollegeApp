import 'package:flutter/material.dart';
import 'package:lbef/screen/student/daily_class_report/widgets/report_detail.dart';


class StackedReports extends StatefulWidget {
  const StackedReports({super.key});

  @override
  State<StackedReports> createState() => _StackedReportsState();
}

class _StackedReportsState extends State<StackedReports> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xffEE4432),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.transparent),
              ),
              child: const Text(
                "2024-04-02",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              "9:30 AM - 11:30 AM",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const ReportDetail(
            head: 'Room No', value: 'A-103', icon: Icons.dashboard_rounded),
        const ReportDetail(
            head: 'Taught in CLass', value: 'Deep Analysis on Literature Review', icon: Icons.chrome_reader_mode_outlined),
        const ReportDetail(
            head: 'Assignment', value: 'Do 16 literature review and start writing proposal with referencing', icon: Icons.assignment),

        const ReportDetail(
            head: 'Activity', value: 'Review other thesis', icon: Icons.read_more),
        const ReportDetail(
            head: 'You Attendence', value: 'Absent', icon: Icons.check_circle),

      ],
    );
  }
}
