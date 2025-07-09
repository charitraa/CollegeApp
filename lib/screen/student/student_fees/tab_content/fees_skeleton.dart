import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lbef/resource/colors.dart'; // Assuming AppColors is defined here

class StatementsShimmer extends StatelessWidget {
  const StatementsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for PayKhalti button
          Shimmer.fromColors(
            baseColor: AppColors.primary.withOpacity(0.7),
            highlightColor: Colors.purple[100]!,
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: size.width * 0.4,
              height: 48, // Assumed height for PayKhalti button
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Shimmer for "Your Statement" text
          Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[50]!,
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: size.width * 0.5,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // Shimmer for StatementCard list
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  3, // Simulate 3 placeholder cards
                      (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[50]!,
                      period: const Duration(milliseconds: 1200),
                      child: Container(
                        width: size.width,
                        height: 100, // Assumed height for StatementCard
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Shimmer for index/serial number
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Shimmer for main content of StatementCard
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: size.width * 0.6,
                                    height: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: size.width * 0.4,
                                    height: 14,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            // Shimmer for action icon/button
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}