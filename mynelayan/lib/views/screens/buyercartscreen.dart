import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mynelayan/models/cart.dart';
import 'package:mynelayan/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mynelayan/myconfig.dart';

class BuyerCartScreen extends StatefulWidget {
  final User user;

  const BuyerCartScreen({super.key, required this.user});

  @override
  State<BuyerCartScreen> createState() => _BuyerCartScreenState();
}

class _BuyerCartScreenState extends State<BuyerCartScreen> {
  List<Cart> cartList = <Cart>[];
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  double totalprice = 0.0;

  @override
  void initState() {
    super.initState();
    loadcart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          cartList.isEmpty
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                width: screenWidth / 3,
                                fit: BoxFit.cover,
                                imageUrl:
                                    "${MyConfig().SERVER}/mynelayan/assets/catches/${cartList[index].catchId}.png",
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Flexible(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        cartList[index].catchName.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.remove)),
                                          Text(cartList[index]
                                              .catchQty
                                              .toString()),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.add),
                                          )
                                        ],
                                      ),
                                      Text(
                                          "RM ${double.parse(cartList[index].cartPrice.toString()).toStringAsFixed(2)}")
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.delete))
                            ],
                          ),
                        ));
                      })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Price RM " + totalprice.toStringAsFixed(2)),
                    ElevatedButton(onPressed: () {}, child: Text("Check Out"))
                  ],
                )),
          )
        ],
      ),
    );
  }

  void loadcart() {
    http.post(Uri.parse("${MyConfig().SERVER}/mynelayan/php/load_cart.php"),
        body: {
          "userid": widget.user.id,
        }).then((response) {
      print(response.body);
      // log(response.body);
      cartList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['carts'].forEach((v) {
            cartList.add(Cart.fromJson(v));
            // totalprice = totalprice +
            //     double.parse(extractdata["carts"]["cart_price"].toString());
          });

          cartList.forEach((element) {
            totalprice =
                totalprice + double.parse(element.cartPrice.toString());
          });
          //print(catchList[0].catchName);
        }
        setState(() {});
      }
    });
  }
}
