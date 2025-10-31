import 'package:flutter/material.dart';
import 'package:lbef/resource/colors.dart';
import 'package:shimmer/shimmer.dart';

class ReportsShimmer extends StatelessWidget {
  const ReportsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer for IndividualCardHead
            Shimmer.fromColors(
              baseColor: AppColors.primary.withOpacity(0.7),
              highlightColor: Colors.purple[100]!,
              period: const Duration(milliseconds: 1200),
              child: Container(
                width: size.width,
                height: 100, // Assumed height for IndividualCardHead
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Shimmer for "View reports" text
            Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[50]!,
              period: const Duration(milliseconds: 1200),
              child: Container(
                width: size.width * 0.6,
                height: 12,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Shimmer for "Section" text
            Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[50]!,
              period: const Duration(milliseconds: 1200),
              child: Container(
                width: size.width * 0.3,
                height: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Shimmer for AttendanceBar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[50]!,
                      period: const Duration(milliseconds: 1200),
                      child: Container(
                        width: 100,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[50]!,
                      period: const Duration(milliseconds: 1200),
                      child: Container(
                        width: 50,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Shimmer.fromColors(
                  baseColor: Colors.amber[100]!, // Light, non-blue color
                  highlightColor: Colors.yellow[100]!, // Light, non-blue color
                  period: const Duration(milliseconds: 1200),
                  child: Container(
                    height: 12,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            ...List.generate(3, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.red[100]!, // Light vibrant date
                        highlightColor: Colors.pink[100]!,
                        period: const Duration(milliseconds: 1200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          width: 100,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[50]!,
                        period: const Duration(milliseconds: 1200),
                        child: Container(
                          width: 80,
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Shimmer for ReportDetail items (room, taught, assignment, activity, teacher, attendance)
                  ...List.generate(6, (detailIndex) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Center(
                              child: Shimmer.fromColors(
                                baseColor: AppColors.primary.withOpacity(0.7), // Match ReportDetail icon
                                highlightColor: Colors.purple[100]!,
                                period: const Duration(milliseconds: 1200),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[50]!,
                            period: const Duration(milliseconds: 1200),
                            child: Container(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 1, bottom: 8),
                              child: Shimmer.fromColors(
                                baseColor: detailIndex == 5 ? Colors.green[100]! : Colors.grey[200]!, // Vibrant for attendance
                                highlightColor: detailIndex == 5 ? Colors.yellow[100]! : Colors.grey[50]!, // Non-blue for attendance
                                period: const Duration(milliseconds: 1200),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: size.width * 0.3,
                                        height: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        width: size.width * 0.6,
                                        height: 13,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}