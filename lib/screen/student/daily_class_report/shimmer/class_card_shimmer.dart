import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lbef/resource/colors.dart';

class ClassCardShimmer extends StatelessWidget {
  const ClassCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10), // Match DownloadForums grid cell padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for icon
          Shimmer.fromColors(
            baseColor: AppColors.primary.withOpacity(0.7),
            highlightColor: Colors.blue[100]!,
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: 36,
              height: 36,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          // Shimmer for title
          Shimmer.fromColors(
            baseColor: Colors.green[100]!,
            highlightColor: Colors.red[100]!,
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: double.infinity, // Use available width
              height: 13,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Shimmer for description
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[50]!,
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: double.infinity,
              height: 33, // Matches 3 lines of text (11px font)
              color: Colors.white,
            ),
          ),
          const Spacer(),
          // Shimmer for publish date
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[50]!,
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: 80,
              height: 10,
              color: Colors.white,
            ),
          ),
          // Shimmer for download icon
          Align(
            alignment: Alignment.bottomRight,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[50]!,
              period: const Duration(milliseconds: 1200),
              child: Container(
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}