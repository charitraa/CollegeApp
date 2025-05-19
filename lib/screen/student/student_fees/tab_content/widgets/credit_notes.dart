import 'package:flutter/material.dart';

Widget buildCreditNotesSection() {
  final creditNotes = [
    {
      'date': '2023-01-24',
      'noteNo': '2079-2080/108',
      'description':
      'Scholarship - L4 Awarded On 2023-01-24 Approved on 2023-01-24 By Super Administrator',
      'amount': 'Rs. 169667',
      'status': 'Settled',
    },
    {
      'date': '2024-02-25',
      'noteNo': '2080-2081/348',
      'description':
      'Scholarship - L5 Awarded On 2024-02-25 Approved on 2024-02-25 By Super Administrator',
      'amount': 'Rs. 119666',
      'status': 'Settled',
    },
    {
      'date': '2025-01-09',
      'noteNo': '2081-2082/261',
      'description':
      'Scholarship - L6 Awarded On 2025-01-09 Approved on 2025-01-09 By Sunanda Regmi',
      'amount': 'Rs. 119666',
      'status': 'Settled',
    },
  ];

  return Column(
    children: creditNotes.map((note) {
      return Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note['date']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(note['noteNo']!, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Text(note['description']!),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(note['amount']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(note['status']!, style: const TextStyle(color: Colors.green)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }).toList(),
  );
}
