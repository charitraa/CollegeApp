import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:shimmer/shimmer.dart';

class ClassCardShimmer extends StatelessWidget {
  const ClassCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[300]!, // Lighter border for soft look
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Lighter shadow
            spreadRadius: 0.5,
            blurRadius: 1.5,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Shimmer for DcrCardImage
          Shimmer.fromColors(
            baseColor: AppColors.primary.withOpacity(0.7), // Light vibrant base
            highlightColor: Colors.blue[100]!, // Light vibrant highlight
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: size.width,
              height: 120, // Assumed height for DcrCardImage
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: size.width,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shimmer for text (title)
                      Shimmer.fromColors(
                        baseColor: Colors.green[100]!, // Light vibrant base
                        highlightColor: Colors.red[100]!, // Light vibrant highlight
                        period: const Duration(milliseconds: 1200),
                        child: Container(
                          width: size.width * 0.6,
                          height: 13,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Shimmer for class code
                          Shimmer.fromColors(
                            baseColor: Colors.grey[200]!, // Very light base
                            highlightColor: Colors.grey[50]!, // Very light highlight
                            period: const Duration(milliseconds: 1200),
                            child: Container(
                              width: size.width * 0.4,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          // Shimmer for faculty
                          Shimmer.fromColors(
                            baseColor: Colors.grey[200]!, // Very light base
                            highlightColor: Colors.grey[50]!, // Very light highlight
                            period: const Duration(milliseconds: 1200),
                            child: Container(
                              width: size.width * 0.3,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
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