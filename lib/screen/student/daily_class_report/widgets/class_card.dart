import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget {
  final String image, text, code;
  const ClassCard(
      {super.key, required this.image, required this.text, required this.code});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width,
            height: 140,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6,),
                Text(
                  "Class Code : $code",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
