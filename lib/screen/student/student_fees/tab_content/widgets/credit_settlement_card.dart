import 'package:flutter/material.dart';

class CreditSettlementCard extends StatelessWidget {
  final String date;
  final String cNoteNo;
  final String fiscal;

  final String type;
  final String amount;

  const CreditSettlementCard({
    super.key,
    required this.date,
    required this.amount, required this.cNoteNo, required this.type, required this.fiscal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildDetailRow('Date', date),
        const SizedBox(height: 12),
        _buildDetailRow('Note Number', "$fiscal/$cNoteNo"),
        const SizedBox(height: 12),
        _buildDetailRow('Settlement Type', type, valueColor: Colors.green.shade700),
        const SizedBox(height: 12),
        _buildDetailRow('Amount', amount, valueColor: Colors.green.shade700),
        const SizedBox(height: 12),

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
