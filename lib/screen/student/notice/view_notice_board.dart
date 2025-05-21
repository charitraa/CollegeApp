import 'package:flutter/material.dart';

import '../../../resource/colors.dart';

class ViewNoticeBoard extends StatelessWidget {
  final Map<String, String> noticeData;

  const ViewNoticeBoard({super.key, required this.noticeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          "Notice Details",
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              noticeData['subBody'] ?? 'No Title',textAlign: TextAlign.center ,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Published on ${noticeData['published'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            const Divider(height: 32, thickness: 1.2),
            Text(
              noticeData['body'] ?? 'No Content Available',
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 28),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Kind Regards,\n${noticeData['sender'] ?? 'Admin'}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
