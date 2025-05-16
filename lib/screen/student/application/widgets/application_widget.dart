import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';

class ApplicationWidget extends StatelessWidget {
  final Color iconColor, textColor,btnColor;
  final String status, title, subBody;
  const ApplicationWidget({super.key, required this.iconColor, required this.textColor, required this.btnColor, required this.status, required this.title, required this.subBody});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Wednesday, December 7th"),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.chrome_reader_mode_rounded,
                  color: iconColor,
                  size: 30,
                ),
                const SizedBox(width: 8),
                 Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subBody,
                        style: TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child:  Text(
                    status,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
