import 'package:flutter/material.dart';

class IndividualCardHead extends StatelessWidget {
  final String image, tutor, subject,code;
  const IndividualCardHead({super.key, required this.image, required this.tutor, required this.subject, required this.code});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Stack(
      children: [
        Container(
          width: size.width,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
         Positioned(
          left: 10,
          bottom: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 4),
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 240,
                    child: Text(
                     "By $tutor",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    code,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
