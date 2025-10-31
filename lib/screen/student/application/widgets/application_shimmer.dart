import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:shimmer/shimmer.dart';

class ApplicationShimmer extends StatelessWidget {
  const ApplicationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for date text
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: 100,
              height: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1.5,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer for status icon with vibrant color
                Shimmer.fromColors(
                  baseColor: AppColors.primary,
                  highlightColor: Colors.blue[200]!,
                  period: const Duration(milliseconds: 1200),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shimmer for title
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        period: const Duration(milliseconds: 1200),
                        child: Container(
                          width: size.width * 0.5,
                          height: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Shimmer for start date
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        period: const Duration(milliseconds: 1200),
                        child: Container(
                          width: size.width * 0.4,
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Shimmer for end date
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        period: const Duration(milliseconds: 1200),
                        child: Container(
                          width: size.width * 0.4,
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Shimmer for "Click to view"
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        period: const Duration(milliseconds: 1200),
                        child: Container(
                          width: size.width * 0.3,
                          height: 11,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Shimmer for status text with vibrant color
                Shimmer.fromColors(
                  baseColor: Colors.green[400]!,
                  highlightColor: Colors.red[200]!,
                  period: const Duration(milliseconds: 1200),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    width: 60,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
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