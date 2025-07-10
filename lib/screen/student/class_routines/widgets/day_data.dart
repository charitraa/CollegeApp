import 'package:flutter/material.dart';
import 'package:lbef/model/routine_model.dart';
import 'package:lbef/widgets/no_data/no_data_widget.dart';
import 'table_row.dart';

class DayDetails extends StatelessWidget {
  final String day;
  final List<Times> times;
  final List<DayItem> days; // Add days list
  final Map<String, dynamic> detail;

  const DayDetails({
    super.key,
    required this.day,
    required this.times,
    required this.days, // Add days parameter
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the day is not in the days list
    if (!days.any((dayItem) => dayItem.day == day)) {
      return Column(
        children: [
          const Row(
            children: [
              SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    "Time",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Courses",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: BuildNoData(
              MediaQuery.of(context).size,
              "No Routine available",
              Icons.calendar_month,
            ),
          ),
        ],
      );
    }

    // Check if detail for the day exists and is not empty
    final dayDetails = detail[day] as Map<String, dynamic>?;
    if (times.isEmpty || dayDetails == null || dayDetails.isEmpty) {
      return Column(
        children: [
          const Row(
            children: [
              SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    "Time",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Courses",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: BuildNoData(
              MediaQuery.of(context).size,
              "No Routine available",
              Icons.calendar_month,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        const Row(
          children: [
            SizedBox(
              width: 80,
              child: Center(
                child: Text(
                  "Time",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Courses",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...times.map((time) {
          final timeKey = "${time.startTime}-${time.endTime}";
          final detailString = dayDetails[timeKey] as String?;

          if (detailString == null || detailString.isEmpty) {
            return Container();
          }

          final parts = detailString.split('<br>');
          final course = parts.isNotEmpty ? parts[0] : 'Unknown Course';
          final teacher = parts.length > 1 ? parts[1] : 'Unknown Teacher';
          final room = parts.length > 2 ? parts[2] : 'Unknown Room';

          return TableData(
            timeStart: time.startTime,
            timeEnd: time.endTime,
            title: course,
            lecture: '',
            room: room,
            teacher: teacher,
            color: const Color(0xff97E793),
            textColor: Colors.black,
          );
        }),
      ],
    );
  }
}