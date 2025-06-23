import 'package:flutter/material.dart';

class StatementDetailsContent extends StatelessWidget {
  final Map<String, dynamic> note;
  final int serialNumber;

  const StatementDetailsContent({
    super.key,
    required this.note,
    required this.serialNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildDetailRow('Serial Number', serialNumber.toString()),
        const SizedBox(height: 12),
        _buildDetailRow('Particular', note['particular'] ?? ''),
        const SizedBox(height: 12),
        _buildDetailRow('Date', note['date'] ?? ''),
        const SizedBox(height: 12),
        _buildDetailRow('Debit', note['dr'] ?? ''),
        const SizedBox(height: 12),
        _buildDetailRow('Credit', note['cr'] ?? ''),
        const SizedBox(height: 12),
        _buildDetailRow('Balance', note['bal'] ?? ''),
        const SizedBox(height: 12),
        _buildDetailRow(
          'Status',
          note['paid'] == true ? 'Paid' : 'Unpaid',
          valueColor: note['paid'] == true ? Colors.green : Colors.red,
        ),
        const SizedBox(height: 12),
        const Text(
          'Remarks',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Text(
            note['remarks'] ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}