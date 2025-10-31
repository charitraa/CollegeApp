import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTextfield extends StatefulWidget {
  final String text;
  final String hintText;
  final Color outlinedColor;
  final bool? obscureText;
  final Color focusedColor;
  final double width;
  final Icon? suffixicon;
  final Icon? prefixicon;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isDateField;

  const CustomDateTextfield({
    super.key,
    required this.hintText,
    required this.outlinedColor,
    this.obscureText,
    required this.focusedColor,
    required this.width,
    required this.text,
    required this.textController,
    this.keyboardType,
    this.onChanged,
    this.suffixicon,
    this.prefixicon,
    this.isDateField = false,
  });

  @override
  State<CustomDateTextfield> createState() => _CustomDateTextfieldState();
}

class _CustomDateTextfieldState extends State<CustomDateTextfield> {
  String? errorText;

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: Colors.red,
            colorScheme: ColorScheme.light(
              primary: Colors.red,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(pickedDate);
      widget.textController.text = formatted;
      widget.onChanged?.call(formatted);
      setState(() {
        errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: widget.textController,
            readOnly: widget.isDateField,
            onChanged: widget.onChanged,
            keyboardType:
            widget.isDateField ? TextInputType.none : widget.keyboardType,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              errorText: errorText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: widget.outlinedColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: widget.focusedColor,
                  width: 1.5,
                ),
              ),
              suffixIcon: widget.isDateField
                  ? IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.red),
                onPressed: _selectDate,
              )
                  : widget.suffixicon,
              prefixIcon: widget.prefixicon,
            ),
          ),
        ],
      ),
    );
  }
}
