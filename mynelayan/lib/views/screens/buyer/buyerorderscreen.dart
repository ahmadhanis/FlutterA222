import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mynelayan/models/order.dart';
import 'package:mynelayan/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mynelayan/appconfig/myconfig.dart';

import 'buyerorderdetailscreen.dart';

class BuyerOrderScreen extends StatefulWidget {
  final User user;
  const BuyerOrderScreen({super.key, required this.user});

  @override
  State<BuyerOrderScreen> createState() => _BuyerOrderScreenState();
}

class _BuyerOrderScreenState extends State<BuyerOrderScreen> {
  late double screenHeight, screenWidth, cardwitdh;

  String status = "Loading...";
  List<Order> orderList = <Order>[];
  @override
  void initState() {
    super.initState();
    loadsellerorders();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Your Order")),
      body: Container(
        child: orderList.isEmpty
            ? Container()
            : Column(
                children: [
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: Row(
                        children: [
                          Flexible(
                              flex: 7,
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/profile.png",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Hello ${widget.user.name}!",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Row(children: [
                                IconButton(
                                  icon: const Icon(Icons.notifications),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {},
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Text("Your Current Order"),
                  Expanded(
                      child: ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                Order myorder =
                                    Order.fromJson(orderList[index].toJson());
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            BuyerOrderDetailsScreen(
                                              order: myorder,
                                            )));
                                // loadsellerorders();
                              },
                              leading: CircleAvatar(
                                  child: Text((index + 1).toString())),
                              title: Text(
                                  "Receipt: ${orderList[index].orderBill}"),
                              trailing: const Icon(Icons.arrow_forward),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Order ID: ${orderList[index].orderId}"),
                                        Text(
                                            "Status: ${orderList[index].orderStatus}")
                                      ]),
                                  Column(
                                    children: [
                                      Text(
                                        "RM ${double.parse(orderList[index].orderPaid.toString()).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text("")
                                    ],
                                  )
                                ],
                              ),
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
