import 'package:flutter/material.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({super.key});

  static const route = "/merchant_dashboard";
  static const routeName = "MerchantDashboard";

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Merchant Dashboard")),
      body: const Center(
        child: Text("Merchant Dashboard"),
      ),
    );
  }
}
