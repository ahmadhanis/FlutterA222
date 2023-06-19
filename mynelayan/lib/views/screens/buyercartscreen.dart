import 'package:flutter/material.dart';
import 'package:mynelayan/models/user.dart';

class BuyerCartScreen extends StatefulWidget {
  final User user;

  const BuyerCartScreen({super.key, required this.user});

  @override
  State<BuyerCartScreen> createState() => _BuyerCartScreenState();
}

class _BuyerCartScreenState extends State<BuyerCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(),
    );
  }
}
