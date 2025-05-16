import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ClassCardShimmer extends StatelessWidget {
  const ClassCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
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
            // Image Placeholder
            Container(
              width: size.width,
              height: 140,
              color: Colors.grey,
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Placeholder
                  Container(
                    width: size.width * 0.8,
                    height: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 6),
                  // Code Placeholder
                  Container(
                    width: size.width * 0.4,
                    height: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
