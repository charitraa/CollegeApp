import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lbef/screen/student/student_fees/tab_content/dialog_content/statement_dialog.dart';
import 'package:lbef/screen/student/student_fees/pay_khalti.dart';
import 'package:lbef/screen/student/student_fees/tab_content/widgets/statement_card.dart';
import 'package:lbef/view_model/college_fees/college_fee_view_model.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/display_dialog/display_dialog.dart';

class Statements extends StatefulWidget {
  const Statements({super.key});

  @override
  State<Statements> createState() => _StatementsState();
}

class _StatementsState extends State<Statements> {
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
    await Provider.of<CollegeFeeViewModel>(context, listen: false)
        .fetchStatement(context);
  }

  Future<void> loadMore() async {
    if (isLoad) return;
    setState(() => isLoad = true);
    try {
      await Provider.of<CollegeFeeViewModel>(context, listen: false)
          .loadMore(context);
    } catch (e) {
      if (kDebugMode) logger.d("Error loading more: $e");
    } finally {
      setState(() => isLoad = false);
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
    // fetch();
  }

  final int rowsPerPage = 10;
  int currentPage = 0;

  final List<Map<String, dynamic>> creditNotes = [
    {
      'date': '2022-12-30',
      'particular': 'Induction Cost Admission',
      'dr': 'Rs. 5000',
      'cr': 'Rs. 5000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
    {
      'date': '2022-12-30',
      'particular': 'University Fee Admission',
      'dr': 'Rs. 200000',
      'cr': 'Rs. 200000',
      'bal': 'Rs. 0',
      'remarks': 'Paid via RECEIPT - 514',
      'paid': true,
    },
    {
      'date': '2023-03-15',
      'particular': 'Lab Fee Inst II Level 4 Sem II',
      'dr': 'Rs. 20000',
      'cr': 'Rs. 20000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
    {
      'date': '2022-12-30',
      'particular': 'Induction Cost Admission',
      'dr': 'Rs. 5000',
      'cr': 'Rs. 5000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
    {
      'date': '2022-12-30',
      'particular': 'University Fee Admission',
      'dr': 'Rs. 200000',
      'cr': 'Rs. 200000',
      'bal': 'Rs. 0',
      'remarks': 'Paid via RECEIPT - 514',
      'paid': true,
    },
    {
      'date': '2023-03-15',
      'particular': 'Lab Fee Inst II Level 4 Sem II',
      'dr': 'Rs. 20000',
      'cr': 'Rs. 20000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
    {
      'date': '2022-12-30',
      'particular': 'Induction Cost Admission',
      'dr': 'Rs. 5000',
      'cr': 'Rs. 5000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
    {
      'date': '2022-12-30',
      'particular': 'University Fee Admission',
      'dr': 'Rs. 200000',
      'cr': 'Rs. 200000',
      'bal': 'Rs. 0',
      'remarks': 'Paid via RECEIPT - 514',
      'paid': true,
    },
    {
      'date': '2023-03-15',
      'particular': 'Lab Fee Inst II Level 4 Sem II',
      'dr': 'Rs. 20000',
      'cr': 'Rs. 20000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
    {
      'date': '2022-12-30',
      'particular': 'Induction Cost Admission',
      'dr': 'Rs. 5000',
      'cr': 'Rs. 5000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
    {
      'date': '2022-12-30',
      'particular': 'University Fee Admission',
      'dr': 'Rs. 200000',
      'cr': 'Rs. 200000',
      'bal': 'Rs. 0',
      'remarks': 'Paid via RECEIPT - 514',
      'paid': true,
    },
    {
      'date': '2023-03-15',
      'particular': 'Lab Fee Inst II Level 4 Sem II',
      'dr': 'Rs. 20000',
      'cr': 'Rs. 20000',
      'bal': 'Rs. 0',
      'remarks': 'Adjusted via CREDIT NOTE - 108',
      'paid': true,
    },
  ];

  List<Map<String, dynamic>> get pagedData {
    final startIndex = currentPage * rowsPerPage;
    final endIndex = (startIndex + rowsPerPage) > creditNotes.length
        ? creditNotes.length
        : startIndex + rowsPerPage;
    return creditNotes.sublist(startIndex, endIndex);
  }

  int get totalPages => (creditNotes.length / rowsPerPage).ceil();

  void _goToPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void _nextPage() {
    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage++;
      });
    }
  }

  Widget _buildPaginationControls() {
    const double buttonSize = 40;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: currentPage > 0 ? _previousPage : null,
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Previous'),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(totalPages, (i) {
            return InkWell(
              onTap: () => _goToPage(i),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: buttonSize,
                height: buttonSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: currentPage == i
                        ? [Colors.blue, Colors.blueAccent]
                        : [Colors.white, Colors.grey.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: currentPage == i ? Colors.white : Colors.black87,
                    fontWeight:
                    currentPage == i ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }),
        ),
        TextButton(
          onPressed: currentPage < totalPages - 1 ? _nextPage : null,
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Next'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PayKhalti(),
          const SizedBox(height: 16),
          const Text(
            'Your Statement',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ScrollConfiguration(
              behavior:
              ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: pagedData.length + (isLoad ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == pagedData.length && isLoad) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    );
                  }
                  return StatementCard(
                    note: pagedData[index],
                    serialNumber: currentPage * rowsPerPage + index + 1,
                    index: index,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DisplayDialog(
                          text: 'Statement Details',
                          show: StatementDetailsContent(
                            note: pagedData[index],
                            serialNumber: currentPage * rowsPerPage + index + 1,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildPaginationControls(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}



