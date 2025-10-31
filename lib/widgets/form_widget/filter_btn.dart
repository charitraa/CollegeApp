import 'package:flutter/material.dart';

Widget BuildFilterButton(
    String title, VoidCallback onTap, Color color, double size) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: size),
      ),
    ),
  );
}