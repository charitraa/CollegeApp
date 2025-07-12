import 'package:flutter/material.dart';
import 'package:lbef/screen/student/daily_class_report/reports/reports.dart';
import 'package:lbef/screen/student/daily_class_report/shimmer/class_card_shimmer.dart';
import 'package:lbef/utils/parse_date.dart';
import 'package:lbef/view_model/daily_class_report/dcr_view_model.dart';
import 'package:lbef/view_model/download_forms/download_forms_view_model.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:lbef/screen/student/daily_class_report/widgets/class_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/navigate_to.dart';
import '../../../widgets/no_data/no_data_widget.dart';

class DownloadForums extends StatefulWidget {
  const DownloadForums({super.key});

  @override
  State<DownloadForums> createState() => _DownloadForumsState();
}

class _DownloadForumsState extends State<DownloadForums> {
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    // await Provider.of<DownloadFormsViewModel>(context, listen: false).fetch(context);
  }
  void openPdf(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the PDF")),
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
        automaticallyImplyLeading: false,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Consumer<DownloadFormsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return GridView.count(
                physics: const AlwaysScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
                children: List.generate(
                  (size.height / 200).ceil(),
                      (index) => const Padding(
                    padding: EdgeInsets.all(4),
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
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
              children: viewModel.downloadsList.map((report) {
                return GestureDetector(
                  onTap: () => openPdf(report.fileLink??''),
                  child: Container(
                    padding: const EdgeInsets.all(12),
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
                        const Icon(Icons.picture_as_pdf,
                            color: Colors.red, size: 40),
                        const SizedBox(height: 10),
                        Text(
                          report.documentName??'',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          report.documentName??'',
                          style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          'Published: ${report.publishOn!=null||report.publishOn!=''?parseDate(report.publishOn??''):""}',
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.download, color: Colors.grey),
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
