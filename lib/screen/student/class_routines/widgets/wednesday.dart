import 'package:flutter/material.dart';
import 'package:lbef/screen/student/class_routines/widgets/table_row.dart';

class Wednesday extends StatelessWidget {
  const Wednesday({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
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
              'Introduction to Software development',
              lecture: 'Lecture 2 : Flutter',
              room: "Room 01 204",
              teacher: 'Season Maharjan',
              color: Color(0xffDCFF7D),
              textColor: Color(0xffE32D2D)),
          SizedBox(height: 15),

          TableData(
              timeStart: '7:00 AM',
              timeEnd: '9:00 AM',
              title:
              'OBJECT ORIENTED PROGRAMMING AND SOFTWARE ENGINEERING',
              lecture: 'Lecture 2 : Data Management Sql',
              room: "Room 3 404",
              teacher: 'Nujan Shrestha',
              color: Color(0xff97E793),
              textColor: Colors.black),
          SizedBox(height: 15),
          TableData(
              timeStart: '10:00 AM',
              timeEnd: '12:00 AM',
              title:
              'Mobile Application Development',
              lecture: 'Lecture 2 : Flutter',
              room: "Room 01 204",
              teacher: 'Season Maharjan',
              color: Color(0xffDCFF7D),
              textColor: Color(0xffE32D2D)),
          SizedBox(height: 15),
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
      ),
    ));
  }
}
