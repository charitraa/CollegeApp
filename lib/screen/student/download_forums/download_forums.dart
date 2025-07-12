import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lbef/utils/permission.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lbef/screen/student/daily_class_report/reports/reports.dart';
import 'package:lbef/screen/student/daily_class_report/shimmer/class_card_shimmer.dart';
import 'package:lbef/utils/parse_date.dart';
import 'package:lbef/view_model/download_forms/download_forms_view_model.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import '../../../resource/colors.dart';
import '../../../widgets/no_data/no_data_widget.dart';

class DownloadForums extends StatefulWidget {
  const DownloadForums({super.key});

  @override
  State<DownloadForums> createState() => _DownloadForumsState();
}

class _DownloadForumsState extends State<DownloadForums> {
  final Logger _logger = Logger();
  final String baseUrl = "https://your-base-url.com/files/";

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    await Provider.of<DownloadFormsViewModel>(context, listen: false).fetch(context);
  }

  Future<void> downloadFile(String fileName, String fileLink) async {
    bool permissionGranted = await requestStoragePermission(context);
    if (!permissionGranted) {
      _logger.w("Storage permission not granted, cannot download file");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied")),
      );
      return;
    }

    if (fileLink.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid file URL")),
      );
      return;
    }

    try {
      final dio = Dio();
      final dir = await getExternalStorageDirectory();
      if (dir == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to access storage directory")),
        );
        return;
      }

      final fullPath = '${dir.path}/$fileName';
      final fullUrl = '$baseUrl$fileLink';

      await dio.download(
        fullUrl,
        fullPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _logger.i("${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloaded $fileName")),
      );

      final result = await OpenFile.open(fullPath);
      if (result.type != ResultType.done) {
        _logger.e("Failed to open file: ${result.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open the file: ${result.message}")),
        );
      }
    } catch (e) {
      _logger.e("Failed to download file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to download file")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Download Forms",
          style: TextStyle(fontFamily: 'poppins', fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
          iconSize: 18,
        ),
        actions: const [
          Image(
            image: AssetImage('assets/images/pcpsLogo.png'),
            width: 70,
            height: 50,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 14),
        ],
      ),
      body: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced horizontal padding
        child: Consumer<DownloadFormsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 14, // Reduced spacing
                crossAxisSpacing: 8, // Reduced spacing
                childAspectRatio: 0.8, // Adjusted for better fit
                children: List.generate(
                  (size.height / 220).ceil(), // Adjusted for screen size
                      (index) => const Padding(
                    padding: EdgeInsets.all(4), // Reduced padding
                    child: ClassCardShimmer(),
                  ),
                ),
              );
            }

            if (viewModel.downloadsList.isEmpty) {
              return SizedBox(
                height: 100,
                child: BuildNoData(
                  size,
                  'No forms available',
                  Icons.disabled_visible_rounded,
                ),
              );
            }

            return GridView.count(
              physics: const AlwaysScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8, // Reduced spacing
              crossAxisSpacing: 8, // Reduced spacing
              childAspectRatio: 0.8, // Adjusted for better fit
              children: viewModel.downloadsList.map((report) {
                return GestureDetector(
                  onTap: () => downloadFile(
                    report.documentName ?? 'Untitled',
                    report.fileLink ?? '',
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10), // Reduced padding
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
                        Icon(
                          report.fileLink?.endsWith('.pdf') ?? false
                              ? Icons.picture_as_pdf
                              : Icons.description,
                          color: report.fileLink?.endsWith('.pdf') ?? false
                              ? Colors.red
                              : Colors.blue,
                          size: 36, // Reduced icon size
                        ),
                        const SizedBox(height: 8),
                        Text(
                          report.documentName ?? 'Untitled',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13, // Reduced font size
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          report.description ?? report.documentName ?? 'No description',
                          style: TextStyle(fontSize: 11, color: Colors.grey[800]), // Reduced font size
                          maxLines: 3, // Reduced max lines
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          'Published: ${report.publishOn != null && report.publishOn!.isNotEmpty ? parseDate(report.publishOn!) : "Unknown"}',
                          style: TextStyle(fontSize: 10, color: Colors.grey[600]), // Reduced font size
                        ),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.download, color: Colors.grey, size: 20), // Reduced icon size
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}