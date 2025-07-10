import 'package:flutter/material.dart';
import 'package:lbef/model/email_notice_model.dart';
import 'package:lbef/utils/parse_date.dart';
import 'package:provider/provider.dart';

import '../../../resource/colors.dart';
import '../../../utils/format_time.dart';
import '../../../utils/utils.dart';
import '../../../view_model/notice_board/email_view_model.dart';

class ViewEmail extends StatefulWidget {
  final EmailNoticeModel emailData;

  const ViewEmail({super.key, required this.emailData});

  @override
  State<ViewEmail> createState() => _ViewEmailState();
}

class _ViewEmailState extends State<ViewEmail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetch());
  }

  void fetch() async {
    final id = widget.emailData.mailId?.toString();
    if (id == null || id.isEmpty) {
      if (context.mounted) {
        Utils.flushBarErrorMessage("Invalid email ID", context);
      }
      return;
    }
    await Provider.of<EmailViewModel>(context, listen: false)
        .getNoticeDetails(id, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: const Text(
          "Email Details",
          style: TextStyle(fontFamily: 'poppins'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image(
              image: AssetImage('assets/images/lbef.png'),
              width: 70,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Consumer<EmailViewModel>(
          builder: (context, provider, child) {
            final isLoading = provider.isLoading;
            final email = provider.currentDetails ?? widget.emailData;

            String date = 'N/A';
            String time = 'N/A';
            if (email.sentOn != null && email.sentOn!.contains(' ')) {
              final parts = email.sentOn!.split(' ');
              date = parseDate(parts[0]);
              time = formatTimeTo12Hour(parts[1]);
            }

            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      email.subject ?? 'No Subject',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Sent on $date at $time',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'From: ${email.mailFromname ?? 'Unknown'} <${email.mailFrom ?? ''}>',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontFamily: 'poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To: ${email.mailToname ?? 'Unknown'} <${email.mailTo ?? ''}>',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontFamily: 'poppins',
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (isLoading)
                    _buildLoadingSkeleton()
                  else
                    Text(
                      stripHtmlTags(email.emailText ?? 'No content available.'),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        fontFamily: 'poppins',
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 16 + (index % 2 == 0 ? 12 : 8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}