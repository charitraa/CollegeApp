import 'package:flutter/material.dart';

Widget buildListTile(IconData icon, String title) {
  return Column(
    children: [
      ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
      const Divider(height: 1),
    ],
  );
}
