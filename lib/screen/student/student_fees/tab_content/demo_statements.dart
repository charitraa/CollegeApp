import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lbef/view_model/college_fees/college_fee_view_model.dart';
import 'package:provider/provider.dart';

class Statements extends StatefulWidget {
  const Statements({super.key});

  @override
  State<Statements> createState() => _StatementsState();
}

class _StatementsState extends State<Statements> {
  final ScrollController _scrollController = ScrollController();
  final int rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    Provider.of<CollegeFeeViewModel>(context, listen: false).fetchStatement(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildPaginationControls(CollegeFeeViewModel provider) {
    const double buttonSize = 40;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: provider.currentPage > 0
              ? () => provider.previousPage(context)
              : null,
          child: const Text("Previous"),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(provider.totalPages, (index) {
            return InkWell(
              onTap: () => provider.goToPage(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: buttonSize,
                height: buttonSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: provider.currentPage == index ? Colors.blue : Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: provider.currentPage == index ? Colors.white : Colors.black,
                    fontWeight:
                    provider.currentPage == index ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }),
        ),
        TextButton(
          onPressed: provider.currentPage < provider.totalPages - 1
              ? () => provider.nextPage(context)
              : null,
          child: const Text("Next"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollegeFeeViewModel>(
      builder: (context, provider, _) {
        final allData = provider.statementList;
        final startIndex = provider.currentPage * rowsPerPage;
        final endIndex = (startIndex + rowsPerPage) > allData.length
            ? allData.length
            : startIndex + rowsPerPage;
        final currentData = allData.sublist(startIndex, endIndex);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Statement',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Scrollbar(
                            controller: _scrollController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            scrollbarOrientation: ScrollbarOrientation.bottom,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: SizedBox(width: 30, child: Text('SN'))),
                                  DataColumn(label: Text('Date')),
                                  DataColumn(label: Text('Particular')),
                                  DataColumn(label: Text('Debit')),
                                  DataColumn(label: Text('Credit')),
                                  DataColumn(label: Text('Balance')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Remarks')),
                                ],
                                rows: List<DataRow>.generate(
                                  currentData.length,
                                      (index) {
                                    final item = currentData[index];
                                    final serial = startIndex + index + 1;
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(serial.toString())),
                                        DataCell(Text(item.date ?? '')),
                                        DataCell(Text(item.particular ?? '')),
                                        DataCell(Text(item.dr ?? '')),
                                        DataCell(Text(item.cr ?? '')),
                                        DataCell(Text(item.remarks ?? '')),
                                        DataCell(
                                          Text(
                                            item.s == true ? 'Paid' : 'Unpaid',
                                            style: TextStyle(
                                              color: item.s == true
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataCell(Text(item.remarks ?? '')),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildPaginationControls(provider),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
