import 'package:flutter/material.dart';

class ReceiptCard extends StatelessWidget {
  final Map<String, dynamic> note;

  const ReceiptCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['particular'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text('Date: ${note['date'] ?? ''}'),
            Text('Debit: ${note['dr'] ?? ''}'),
            Text('Credit: ${note['cr'] ?? ''}'),
            Text('Balance: ${note['bal'] ?? ''}'),
            Text(
              'Status: ${note['paid'] == true ? "Paid" : "Unpaid"}',
              style: TextStyle(
                color: note['paid'] == true ? Colors.green : Colors.red,
              ),
            ),
            Text('Remarks: ${note['remarks'] ?? ''}'),
          ],
        ),
      ),
    );
  }
}
