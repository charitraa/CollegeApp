import 'package:flutter/material.dart';
import 'package:lbef/screen/student/class_routines/widgets/table_row.dart';

class Thursday extends StatelessWidget {
  const Thursday({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  "Time",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Courses",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        TableData(
            timeStart: '1:00 AM',
            timeEnd: '3:00 AM',
            title:
            'RESEARCH METHODOLOGIES AND EMERGING TECHNOLOGIES',
            lecture: 'Lecture 2 : Literature Review',
            room: "Room 01 204",
            teacher: 'Tara GC',
            color: Color(0xffA4BED3),
            textColor: Colors.white),
      ],
    );
  }
}
