import 'package:flutter/material.dart';
import 'package:mynelayan/models/user.dart';

class OrderScreen extends StatefulWidget {
  final User user;
  const OrderScreen({super.key, required this.user});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Order")),
      body: Container(),
    );
  }
}
