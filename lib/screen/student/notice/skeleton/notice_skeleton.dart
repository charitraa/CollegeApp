import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:shimmer/shimmer.dart';

class NoticeShimmer extends StatelessWidget {
  const NoticeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              // Shimmer for icon
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
                    // Shimmer for subBody
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      period: const Duration(milliseconds: 1200),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Shimmer for published date
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}