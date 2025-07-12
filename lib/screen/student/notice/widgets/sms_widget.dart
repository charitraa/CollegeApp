import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:lbef/utils/parse_date.dart';
import 'package:lbef/utils/format_time.dart';

class SMSWidget extends StatelessWidget {
  final String smsMessage;
  final String sentOn;

  const SMSWidget({
    super.key,
    required this.smsMessage,
    required this.sentOn,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Split sentOn into date and time
    String date = 'N/A';
    String time = 'N/A';
    if (sentOn.isNotEmpty && sentOn.contains(' ')) {
      final parts = sentOn.split(' ');
      date = parseDate(parts[0]);
      time = formatTimeTo12Hour(parts[1]);
    }

    return Container(
      padding: const EdgeInsets.all(8),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.sms_outlined, size: 30, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SMS Message
                Container(
                  width:double.infinity,
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    smsMessage,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 6),

                // Sent Date & Time
                Text(
                  "Date: $date    Time: $time",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
