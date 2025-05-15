import 'package:flutter/material.dart';
import 'package:lbef/screen/student/daily_class_report/widgets/class_card.dart';

class DailyClassReport extends StatefulWidget {
  const DailyClassReport({super.key});

  @override
  State<DailyClassReport> createState() => _DailyClassReportState();
}

class _DailyClassReportState extends State<DailyClassReport> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Daily Class Reports",
          style: TextStyle(fontFamily: 'poppins', fontSize: 18),
        ),
        automaticallyImplyLeading: false,
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
        padding: const EdgeInsets.all(10),
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ClassCard(
                image: 'assets/images/content.png',
                text: "OBJECT ORIENTED PROGRAMMING AND SOFTWARE ENGINEERING",
                code: 'CIS-0756465',
              ),
              SizedBox(height: 14,),
              ClassCard(
                image: 'assets/images/content.png',
                text: "OBJECT ORIENTED PROGRAMMING AND SOFTWARE ENGINEERING",
                code: 'CIS-0756465',
              ),
              SizedBox(height: 14,),
          
              ClassCard(
                image: 'assets/images/content.png',
                text: "OBJECT ORIENTED PROGRAMMING AND SOFTWARE ENGINEERING",
                code: 'CIS-0756465',
              ),
              SizedBox(height: 18,),
            ],
          ),
        ),
      ),
    );
  }
}
