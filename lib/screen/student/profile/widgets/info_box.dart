import 'package:flutter/material.dart';

Widget infoBox(String value, String label) {
  return Container(
    width: 160,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF4B88C5)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B88C5)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
