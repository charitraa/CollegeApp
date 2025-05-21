import 'package:flutter/material.dart';

Widget notificationCard({
  required String avatar,
  required String title,
  required String message,
  required String time,
  bool quoted = false,
}) {
  return ListTile(
    leading: Stack(
      children: [
        CircleAvatar(backgroundImage: NetworkImage(avatar)),
        const Positioned(
          top: 0,
          right: 0,
          child: Icon(Icons.circle, color: Color(0xFF4B88C5), size: 10),
        ),
      ],
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: quoted
                ? const EdgeInsets.symmetric(horizontal: 8, vertical: 6)
                : EdgeInsets.zero,
            decoration: quoted
                ? BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  )
                : null,
            child: Text(
              message,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(color: Colors.grey, fontSize: 11),
        ),
      ],
    ),
    isThreeLine: true,
  );
}
