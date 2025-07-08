import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildBalanceCard({
  required IconData icon,
  required String title,
  required String amountRs,
  required String amountPound,
  Color? color,
}) {
  return Card(
    color: color ?? Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.black54),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(amountRs, style: const TextStyle(fontSize: 14)),
          Text(amountPound, style: const TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}
