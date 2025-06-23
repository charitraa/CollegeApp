import 'package:flutter/material.dart';

class PayKhalti extends StatefulWidget {
  const PayKhalti({super.key});

  @override
  State<PayKhalti> createState() => _PayKhaltiState();
}

class _PayKhaltiState extends State<PayKhalti> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Initiating Khalti Payment...')),
        );
      },
      icon: const Icon(Icons.payment, color: Colors.white),
      label: const Text(
        'Pay with Khalti',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
