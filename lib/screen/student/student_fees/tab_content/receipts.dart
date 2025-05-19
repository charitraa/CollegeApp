import 'package:flutter/material.dart';
import 'package:lbef/screen/student/student_fees/tab_content/widgets/receipt_card.dart';

class Receipts extends StatefulWidget {
  const Receipts({super.key});

  @override
  State<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  final creditNotes = [
    {
      'date': '2023-01-24',
      'receiptNo': '2079-2080/498  Settled',
      'amount': 'Rs. 50,000',
      'tax': 'Rs. 0',
    },
    {
      'date': '2023-02-15',
      'receiptNo': '2079-2080/510  Settled',
      'amount': 'Rs. 40,000',
      'tax': 'Rs. 500',
    },
    {
      'date': '2023-03-05',
      'receiptNo': '2079-2080/528  Settled',
      'amount': 'Rs. 60,000',
      'tax': 'Rs. 1,000',
    },
    {
      'date': '2023-04-12',
      'receiptNo': '2079-2080/542  Settled',
      'amount': 'Rs. 45,000',
      'tax': 'Rs. 250',
    },
    {
      'date': '2023-05-30',
      'receiptNo': '2079-2080/559  Settled',
      'amount': 'Rs. 55,000',
      'tax': 'Rs. 0',
    },
    {
      'date': '2023-06-18',
      'receiptNo': '2080-2081/101  Settled',
      'amount': 'Rs. 70,000',
      'tax': 'Rs. 1,200',
    },
    {
      'date': '2023-07-24',
      'receiptNo': '2080-2081/123  Settled',
      'amount': 'Rs. 35,000',
      'tax': 'Rs. 300',
    },
    {
      'date': '2023-08-10',
      'receiptNo': '2080-2081/139  Settled',
      'amount': 'Rs. 80,000',
      'tax': 'Rs. 1,500',
    },
    {
      'date': '2023-09-01',
      'receiptNo': '2080-2081/158  Settled',
      'amount': 'Rs. 65,000',
      'tax': 'Rs. 700',
    },
    {
      'date': '2023-10-20',
      'receiptNo': '2080-2081/179  Settled',
      'amount': 'Rs. 90,000',
      'tax': 'Rs. 2,000',
    },
    {
      'date': '2023-11-03',
      'receiptNo': '2080-2081/194  Settled',
      'amount': 'Rs. 30,000',
      'tax': 'Rs. 100',
    },
    {
      'date': '2023-12-11',
      'receiptNo': '2080-2081/210  Settled',
      'amount': 'Rs. 75,000',
      'tax': 'Rs. 1,100',
    },
    {
      'date': '2024-01-09',
      'receiptNo': '2080-2081/225  Settled',
      'amount': 'Rs. 20,000',
      'tax': 'Rs. 0',
    },
    {
      'date': '2024-02-15',
      'receiptNo': '2080-2081/240  Settled',
      'amount': 'Rs. 85,000',
      'tax': 'Rs. 1,800',
    },
    {
      'date': '2024-03-18',
      'receiptNo': '2080-2081/260  Settled',
      'amount': 'Rs. 95,000',
      'tax': 'Rs. 2,500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Receipts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ...creditNotes.map((note) => buildReceiptCard(note)).toList(),
        ],
      ),
    );
  }


}
