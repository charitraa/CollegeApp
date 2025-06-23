import 'package:flutter/material.dart';
import 'package:lbef/screen/student/student_fees/pay_khalti.dart';
import 'package:lbef/screen/student/student_fees/tab_content/widgets/balance_card.dart';
import 'package:lbef/screen/student/student_fees/tab_content/widgets/credit_notes.dart';
import 'package:lbef/widgets/no_data/no_data_widget.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PayKhalti(),
          const SizedBox(height: 16),
          const Text(
            'Your Balance',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: buildBalanceCard(
                  icon: Icons.account_balance_wallet,
                  title: 'Total Due',
                  amountRs: 'Rs. 1138500',
                  amountPound: '£ 1225',
                  color: Colors.red[100],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildBalanceCard(
                  icon: Icons.payment,
                  title: 'Total Paid',
                  amountRs: 'Rs. 1113500',
                  amountPound: '£ 1225',
                  color: Colors.green[100],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildBalanceCard(
                  icon: Icons.account_balance,
                  title: 'Balance',
                  amountRs: 'Rs. 25000',
                  amountPound: '£ 0',
                  color: Colors.blue[100],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Your Credit Notes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          buildCreditNotesSection(context),
          const SizedBox(height: 20),
          const Text(
            'Your Credit Settlements',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

         BuildNoData(size, "No settlements available!", Icons.do_not_disturb),
          const SizedBox(height: 30),
        ],
      ),
    );
  }


}
