import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mynelayan/models/cart.dart';
import 'package:mynelayan/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mynelayan/appconfig/myconfig.dart';
import 'package:mynelayan/views/screens/buyer/billscreen.dart';

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
                                              onPressed: () {
                                                if (int.parse(cartList[index]
                                                        .cartQty
                                                        .toString()) <=
                                                    1) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Quantity less than 1")));
                                                  //userqty = 1;
                                                  //totalprice = singleprice * userqty;
                                                } else {
                                                  int newqty = int.parse(
                                                          cartList[index]
                                                              .cartQty
                                                              .toString()) -
                                                      1;

                                                  double newprice =
                                                      double.parse(
                                                              cartList[index]
                                                                  .catchPrice
                                                                  .toString()) *
                                                          newqty;
                                                  updateCart(
                                                      index, newqty, newprice);
                                                  //userqty = userqty - 1;
                                                  //totalprice = singleprice * userqty;
                                                }
                                                setState(() {});
                                              },
                                              icon: const Icon(Icons.remove)),
                                          Text(cartList[index]
                                              .cartQty
                                              .toString()),
                                          IconButton(
                                            onPressed: () {
                                              if (int.parse(cartList[index]
                                                      .catchQty
                                                      .toString()) >
                                                  int.parse(cartList[index]
                                                      .cartQty
                                                      .toString())) {
                                                int newqty = int.parse(
                                                        cartList[index]
                                                            .cartQty
                                                            .toString()) +
                                                    1;

                                                double newprice = double.parse(
                                                        cartList[index]
                                                            .catchPrice
                                                            .toString()) *
                                                    newqty;
                                                updateCart(
                                                    index, newqty, newprice);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Quantity not available")));
                                              }
                                            },
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
                                  onPressed: () {
                                    deleteDialog(index);
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ));
                      })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price RM ${totalprice.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => BillScreen(
                                        user: widget.user,
                                        totalprice: totalprice,
                                      )));
                                      loadcart();
                        },
                        child: const Text("Check Out"))
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
          totalprice = 0.0;

          for (var element in cartList) {
            totalprice =
                totalprice + double.parse(element.cartPrice.toString());
            //print(element.catchPrice);
          }
          //print(catchList[0].catchName);
        } else {
          Navigator.of(context).pop();
        }
        setState(() {});
      }
    });
  }

  void deleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Delete this item?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                deleteCart(index);
                //registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteCart(int index) {
    http.post(Uri.parse("${MyConfig().SERVER}/mynelayan/php/delete_cart.php"),
        body: {
          "cartid": cartList[index].cartId,
        }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          loadcart();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Delete Failed")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Delete Failed")));
      }
    });
  }

  void updateCart(int index, int newqty, double newprice) {
    http.post(Uri.parse("${MyConfig().SERVER}/mynelayan/php/update_cart.php"),
        body: {
          "cartid": cartList[index].cartId,
          "newqty": newqty.toString(),
          "newprice": newprice.toString()
        }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          loadcart();
        } else {}
      } else {}
    });
  }
}
