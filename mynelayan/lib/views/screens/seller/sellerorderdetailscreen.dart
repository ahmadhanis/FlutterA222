import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mynelayan/appconfig/myconfig.dart';
import 'package:mynelayan/models/catchdetails.dart';
import 'package:mynelayan/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:mynelayan/models/user.dart';

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
  String selectStatus = "New";
  // ignore: prefer_typing_uninitialized_variables
  var pickupLatLng;
  List<String> statusList = ["New", "Processing", "Ready", "Completed"];
  late User user = User(
      id: "na",
      name: "na",
      email: "na",
      phone: "na",
      datereg: "na",
      password: "na",
      otp: "na");
  String picuploc = "Not selected";
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kchanglun = CameraPosition(
    target: LatLng(6.4301523, 100.4287586),
    zoom: 12.4746,
  );

  @override
  void initState() {
    super.initState();
    loadbuyer();
    loadorderdetails();
    selectStatus = widget.order.orderStatus.toString();
    if (widget.order.orderLat.toString() == "") {
      picuploc = "Not selected";
    } else {
      picuploc = "Selected";
      pickupLatLng = LatLng(double.parse(widget.order.orderLat.toString()),
          double.parse(widget.order.orderLng.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: Column(children: [
        Flexible(
          flex: 3,
          //height: screenHeight / 5.5,
          child: Card(
              child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                width: screenWidth * 0.3,
                child: Image.asset(
                  "assets/images/profile.png",
                ),
              ),
              Column(
                children: [
                  user.id == "na"
                      ? const Center(
                          child: Text("Loading..."),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Buyer name: ${user.name}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text("Phone: ${user.phone}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                              Text("Order ID: ${widget.order.orderId}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                              Text(
                                "Total Paid: RM ${double.parse(widget.order.orderPaid.toString()).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text("Status: ${widget.order.orderStatus}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        )
                ],
              )
            ],
          )),
        ),
        Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      pickupDialog();
                    },
                    child: const Text("Select Pickup Location")),
                Text(picuploc)
              ],
            )),
        orderdetailsList.isEmpty
            ? Container()
            : Expanded(
                flex: 8,
                child: ListView.builder(
                    itemCount: orderdetailsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderdetailsList[index]
                                        .catchName
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Quantity: ${orderdetailsList[index].orderdetailQty}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Paid: RM ${double.parse(orderdetailsList[index].orderdetailPaid.toString()).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      );
                    })),
        SizedBox(
          // color: Colors.red,
          width: screenWidth,
          height: screenHeight * 0.1,
          child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Set Order Status"),
                  DropdownButton(
                    itemHeight: 60,
                    value: selectStatus,
                    onChanged: (newValue) {
                      setState(() {
                        selectStatus = newValue.toString();
                      });
                    },
                    items: statusList.map((selectStatus) {
                      return DropdownMenuItem(
                        value: selectStatus,
                        child: Text(
                          selectStatus,
                        ),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        submitStatus(selectStatus);
                      },
                      child: const Text("Submit"))
                ]),
          ),
        )
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

  void loadbuyer() {
    http.post(Uri.parse("${MyConfig().SERVER}/mynelayan/php/load_user.php"),
        body: {
          "userid": widget.order.buyerId,
        }).then((response) {
      // log(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          user = User.fromJson(jsondata['data']);
        }
      }
      setState(() {});
    });
  }

  void submitStatus(String st) {
    if (pickupLatLng == null) {
      Fluttertoast.showToast(
          msg: "Please select pickup location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      return;
    }
    String lat = pickupLatLng.latitude.toString();
    String lng = pickupLatLng.longitude.toString();

    http.post(
        Uri.parse("${MyConfig().SERVER}/mynelayan/php/set_orderstatus.php"),
        body: {
          "orderid": widget.order.orderId,
          "status": st,
          "lat": lat,
          "lng": lng
        }).then((response) {
      log(response.body);
      //orderList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
        } else {}
        widget.order.orderStatus = st;
        selectStatus = st;
        setState(() {});
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }

  pickupDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select your pickup location"),
              content: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kchanglun,
                markers: markers.toSet(),
                onTap: (newLatLng) {
                  // print(newLatLng.latitude);
                  // print(newLatLng.longitude);
                  MarkerId markerId1 = const MarkerId("1");
                  markers.clear();
                  markers.add(Marker(
                    markerId: markerId1,
                    position: LatLng(newLatLng.latitude, newLatLng.longitude),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  ));
                  pickupLatLng = newLatLng;
                  setState(() {});
                },
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (pickupLatLng == null) {
                      Fluttertoast.showToast(
                          msg: "Please select pickup location from map",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0);
                      return;
                    } else {
                      Navigator.pop(context);
                      picuploc = "Selected";
                    }
                  },
                  child: const Text("Select"),
                ),
              ],
            );
          },
        );
      },
    ).then((val) {
      setState(() {});
    });
  }
}
