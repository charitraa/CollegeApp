import 'package:flutter/material.dart';

Widget buildListTile(IconData icon, String title, Function() onPressed) {
  return Column(
    children: [
      ListTile(
        leading: Icon(icon, color: const Color(0xFF4B88C5)),
        title: Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          onPressed();
        },
      ),
      const Divider(height: 1),
    ],
  );
}
