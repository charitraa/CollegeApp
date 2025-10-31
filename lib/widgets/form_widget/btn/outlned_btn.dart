import 'package:flutter/material.dart';

class CustomOutlineButton extends StatefulWidget {
  final void Function()? onPressed;
  final String labelText;
  final double width;
  final double height;
  final Color buttonColor;
  final Color textColor;
  final Icon? icon; // Add icon property

  const CustomOutlineButton({
    super.key,
    this.onPressed,
    required this.labelText,
    required this.width,
    required this.height,
    required this.buttonColor,
    required this.textColor,
    this.icon, // Accept icon in constructor
  });

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: widget.textColor, // Text color
        backgroundColor: Colors.white, // Set background color for button
        side: BorderSide(color: widget.buttonColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(widget.width, widget.height),
        elevation: 1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            widget.icon!,
            const SizedBox(width: 8), // Space between icon and text
          ],
          Text(
            widget.labelText,
            style: TextStyle(
              color: widget.textColor, // Set the text color
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
