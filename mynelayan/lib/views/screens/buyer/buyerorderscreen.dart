import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynelayan/models/order.dart';
import 'package:mynelayan/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mynelayan/appconfig/myconfig.dart';

class BuyerOrderScreen extends StatefulWidget {
  final User user;
  const BuyerOrderScreen({super.key, required this.user});

  @override
  State<BuyerOrderScreen> createState() => _BuyerOrderScreenState();
}

class _BuyerOrderScreenState extends State<BuyerOrderScreen> {
  String status = "Loading...";
  List<Order> orderList = <Order>[];
  @override
  void initState() {
    super.initState();
    loadsellerorders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Order")),
      body: Container(
        child: orderList.isEmpty
            ? Container()
            : Column(
                children: [
                  const Text("Your Current Order"),
                  Expanded(
                      child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.money),
                              title:
                                  Text(orderList[index].orderBill.toString()),
                              trailing: const Icon(Icons.more_vert),
                              
                              subtitle: Text(
                                  "RM ${double.parse(orderList[index].orderPaid.toString()).toStringAsFixed(2)}"),
                            );
                          })),
                ],
              ),
      ),
    );
  }

  //  Text(orderList[index].orderBill.toString()),
  //                               Text(orderList[index].orderStatus.toString()),
  //                               Text(orderList[index].orderPaid.toString()),

  void loadsellerorders() {
    http.post(
        Uri.parse("${MyConfig().SERVER}/mynelayan/php/load_sellerorder.php"),
        body: {"sellerid": widget.user.id}).then((response) {
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['orders'].forEach((v) {
            orderList.add(Order.fromJson(v));
          });
          // print(orderList[0].catchName);
        } else {
          status = "Please register an account first";
          setState(() {});
        }
        setState(() {});
      }
    });
  }
}
