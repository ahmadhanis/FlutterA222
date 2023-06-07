import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mynelayan/models/catch.dart';
import 'package:mynelayan/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mynelayan/myconfig.dart';

import 'sellerdetailscreen.dart';

//for buyer screen

class BuyerTabScreen extends StatefulWidget {
  final User user;
  const BuyerTabScreen({super.key, required this.user});

  @override
  State<BuyerTabScreen> createState() => _BuyerTabScreenState();
}

class _BuyerTabScreenState extends State<BuyerTabScreen> {
  String maintitle = "Buyer";
  List<Catch> catchList = <Catch>[];
  late double screenHeight, screenWidth;
  late int axiscount = 2;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadCatches();
    print("Buyer");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
        actions: [
          IconButton(
              onPressed: () {
                showsearchDialog();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: catchList.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Column(children: [
              Container(
                height: 24,
                color: Theme.of(context).colorScheme.primary,
                alignment: Alignment.center,
                child: Text(
                  "${catchList.length} Catches Found",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: axiscount,
                      children: List.generate(
                        catchList.length,
                        (index) {
                          return Card(
                            child: InkWell(
                              onTap: () {
                                Catch usercatch =
                                    Catch.fromJson(catchList[index].toJson());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            SellerDetailsScreen(
                                              user: widget.user,
                                              usercatch: usercatch,
                                            )));
                              },
                              child: Column(children: [
                                CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${MyConfig().SERVER}/mynelayan/assets/catches/${catchList[index].catchId}.png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Text(
                                  catchList[index].catchName.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "RM ${double.parse(catchList[index].catchPrice.toString()).toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "${catchList[index].catchQty} available",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ]),
                            ),
                          );
                        },
                      )))
            ]),
    );
  }

  void loadCatches() {
    http.post(Uri.parse("${MyConfig().SERVER}/mynelayan/php/load_catches.php"),
        body: {}).then((response) {
      //print(response.body);
      log(response.body);
      catchList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['catches'].forEach((v) {
            catchList.add(Catch.fromJson(v));
          });
          print(catchList[0].catchName);
        }
        setState(() {});
      }
    });
  }

  void showsearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Search?",
            style: TextStyle(),
          ),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ))),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton(
                onPressed: () {
                  String search = searchController.text;
                  searchCatch(search);
                  Navigator.of(context).pop();
                },
                child: const Text("Search"))
          ]),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
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

  void searchCatch(String search) {
    http.post(Uri.parse("${MyConfig().SERVER}/mynelayan/php/load_catches.php"),
        body: {"search": search}).then((response) {
      //print(response.body);
      log(response.body);
      catchList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['catches'].forEach((v) {
            catchList.add(Catch.fromJson(v));
          });
          print(catchList[0].catchName);
        }
        setState(() {});
      }
    });
  }
}
