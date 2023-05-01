import 'package:flutter/material.dart';

// for fisherman screen

class SellerTabScreen extends StatefulWidget {
  const SellerTabScreen({super.key});

  @override
  State<SellerTabScreen> createState() => _SellerTabScreenState();
}

class _SellerTabScreenState extends State<SellerTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Seller";

  @override
  void initState() {
    super.initState();
    print("Seller");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(maintitle),
    );
  }
}
