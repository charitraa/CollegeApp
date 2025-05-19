import 'package:flutter/material.dart';

Widget buildReceiptCard(Map<String, String> note) {
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 10),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(note['date']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(note['receiptNo']!, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Amount: ${note['amount']!}", style: const TextStyle(fontSize: 14)),
              Text("Tax: ${note['tax']!}", style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    ),
  );
}