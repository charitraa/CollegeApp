import 'package:flutter/material.dart';
class CustomOutlined extends StatefulWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String text;
  const CustomOutlined({super.key, required this.onPressed, required this.icon, required this.text,});

  @override
  State<CustomOutlined> createState() => _CustomGoogleIconState();
}

class _CustomGoogleIconState extends State<CustomOutlined> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: widget.onPressed,
      icon:widget.icon, // The icon to be displayed
      label:  Text(widget.text,
          style:const TextStyle(
              fontFamily: 'poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400)), // The text to be displayed
      style: OutlinedButton.styleFrom(
        // foregroundColor: Colors.yellow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        fixedSize: const Size(150, 32),
      ),
    );
  }
}
