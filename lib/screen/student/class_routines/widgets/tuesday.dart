import 'package:flutter/material.dart';
import 'package:lbef/screen/student/class_routines/widgets/table_row.dart';

class Tuesday extends StatelessWidget {
  const Tuesday({super.key});

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
            timeStart: '10:00 AM',
            timeEnd: '12:00 AM',
            title:
            'PCPS Skills Development',
            lecture: 'Lecture 2 : Flutter',
            room: "Room 01 204",
            teacher: 'Season Maharjan',
            color: Color(0xffDCFF7D),
            textColor: Color(0xffE32D2D)),

      ],
    );
  }
}
