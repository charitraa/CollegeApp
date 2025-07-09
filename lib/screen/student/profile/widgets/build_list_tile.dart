import 'package:flutter/material.dart';

Widget buildListTile(IconData icon, String title, Function() onPressed) {
  return ListTile(
    leading: Icon(icon, color: Colors.black, size: 24),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
    onTap: onPressed,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    tileColor: Colors.grey[50],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
