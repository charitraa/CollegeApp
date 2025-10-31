import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:shimmer/shimmer.dart';

class EmailShimmer extends StatelessWidget {
  const EmailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for email icon
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer for subject
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
                const SizedBox(height: 6),
                // Shimmer for date and time
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
                const SizedBox(height: 6),
                // Shimmer for sender name
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  period: const Duration(milliseconds: 1200),
                  child: Container(
                    width: size.width * 0.3,
                    height: 12,
                    color: Colors.white,
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