import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lbef/view_model/download_forms/download_forms_view_model.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/document.dart';
import '../../../resource/colors.dart';

class DocumentListPage extends StatefulWidget {
  @override
  _DocumentListPageState createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  late ScrollController _scrollController;
  var logger = Logger();
  bool isLoad = false;

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoad) {
      loadMore();
    }
  }

  void fetch() async {
    await Provider.of<DownloadFormViewModel>(context, listen: false)
        .fetch(context);
  }

  Future<void> loadMore() async {
    if (isLoad) return;
    setState(() => isLoad = true);
    try {
      await Provider.of<DownloadFormViewModel>(context, listen: false)
          .loadMore(context);
    } catch (e) {
      if (kDebugMode) logger.d("Error loading more: $e");
    } finally {
      setState(() => isLoad = false);
    }
  }

  List<Document> documents = [];
  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
    // fetch();
    documents = getDocuments();
  }

  List<Document> getDocuments() {
    return [
      Document(
        title: 'Online Course Enrollment Contract',
        description:
            'This contract is for students to enroll based on their course and level options.',
        publishedDate: '2019-06-10',
        pdfUrl:
            'https://edusys.patancollege.edu.np/html/profiles/downloads/Online_Course_Enrollment_Contract_35b7bbb6408cfb.pdf',
      ),
      Document(
        title: 'Group Weekly Progress Report',
        description:
            'Required for group assessments. Submit weekly to faculty, HOD, and Program Coordinator.',
        publishedDate: '2019-06-10',
        pdfUrl: 'https://example.com/group_weekly_progress_report.pdf',
      ),
      Document(
        title: 'Individual Weekly Progress Report',
        description:
            'Submit weekly to faculty, HOD, and Program Coordinator for individual assessments.',
        publishedDate: '2019-06-10',
        pdfUrl: 'https://example.com/individual_weekly_progress_report.pdf',
      ),
      Document(
        title: 'Character Certificate Application',
        description:
            'Fill, print, and submit this to the program coordinator for processing.',
        publishedDate: '2019-06-10',
        pdfUrl: 'https://example.com/character_certificate_application.pdf',
      ),
      Document(
        title: 'Security Deposit Refund Application',
        description:
            'Fill and submit this to the accounts department for refund processing.',
        publishedDate: '2019-06-10',
        pdfUrl: 'https://example.com/security_deposit_refund.pdf',
      ),
    ];
  }

  void openPdf(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open the PDF")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text(
          "Download Forms",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          physics: AlwaysScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
          children: documents.map((doc) {
            return GestureDetector(
              onTap: () => openPdf(doc.pdfUrl),
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
                      doc.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      doc.description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      'Published: ${doc.publishedDate}',
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
        ),
      ),
    );
  }
}
