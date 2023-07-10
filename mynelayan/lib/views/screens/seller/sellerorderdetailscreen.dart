import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mynelayan/appconfig/myconfig.dart';
import 'package:mynelayan/models/catchdetails.dart';
import 'package:mynelayan/models/order.dart';
import 'package:http/http.dart' as http;

class SellerOrderDetailsScreen extends StatefulWidget {
  final Order order;
  const SellerOrderDetailsScreen({super.key, required this.order});

  @override
  State<SellerOrderDetailsScreen> createState() =>
      _SellerOrderDetailsScreenState();
}

class _SellerOrderDetailsScreenState extends State<SellerOrderDetailsScreen> {
  List<OrderDetails> orderdetailsList = <OrderDetails>[];
  late double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
    loadorderdetails();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: Column(children: [
        orderdetailsList.isEmpty
            ? Container()
            : Expanded(
                child: ListView.builder(
                    itemCount: orderdetailsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(children: [
                          CachedNetworkImage(
                            width: screenWidth / 3,
                            fit: BoxFit.cover,
                            imageUrl:
                                "${MyConfig().SERVER}/mynelayan/assets/catches/${orderdetailsList[index].catchId}.png",
                            placeholder: (context, url) =>
                                const LinearProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Column(
                            children: [
                              Text(
                                orderdetailsList[index].catchName.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ]),
                      );
                    }))
      ]),
    );
  }

  void loadorderdetails() {
    http.post(
        Uri.parse(
            "${MyConfig().SERVER}/mynelayan/php/load_sellerorderdetails.php"),
        body: {
          "sellerid": widget.order.sellerId,
          "orderbill": widget.order.orderBill
        }).then((response) {
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['orderdetails'].forEach((v) {
            orderdetailsList.add(OrderDetails.fromJson(v));
          });
        } else {
          // status = "Please register an account first";
          // setState(() {});
        }
        setState(() {});
      }
    });
  }
}
