import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final int? width;
  final bool? isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = const Color(0xFF1967B5),
    this.width,
    this.isLoading, // Default color
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const List<Color> _kDefaultRainbowColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        minimumSize: const MaterialStatePropertyAll(
          Size(double.infinity, 50),
        ),
        backgroundColor: MaterialStatePropertyAll(widget.buttonColor),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
      child: widget.isLoading!
          ? const SizedBox(
              height: 28,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulseSync,
                colors: _kDefaultRainbowColors,
                strokeWidth: 2.0,
              ),
            )
          : Text(
              widget.text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
    );
  }
}
