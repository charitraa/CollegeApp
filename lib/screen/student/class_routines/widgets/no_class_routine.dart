import 'package:flutter/material.dart';

import '../../../../utils/format_time.dart';

class NoClassesCard extends StatelessWidget {
  final String timeStart;
  final String timeEnd;

  const NoClassesCard({
    super.key,
    required this.timeStart,
    required this.timeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 80,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timeStart.isNotEmpty
                        ? formatTimeTo12HourSimple(timeStart)
                        : '',
                  ),
                  const SizedBox(height: 5),
                  Text(
                    timeEnd.isNotEmpty ? formatTimeTo12HourSimple(timeEnd) : '',
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only( top:10,left: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 15),
                child: const Center(
                  child: Text(
                    'No Classes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}