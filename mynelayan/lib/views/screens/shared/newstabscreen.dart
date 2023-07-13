import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mynelayan/appconfig/myconfig.dart';
import 'package:mynelayan/models/news.dart';
import 'package:mynelayan/models/user.dart';
import 'package:http/http.dart' as http;

// for profile screen

class NewsTabScreen extends StatefulWidget {
  final User user;

  const NewsTabScreen({super.key, required this.user});

  @override
  State<NewsTabScreen> createState() => _NewsTabScreenState();
}

class _NewsTabScreenState extends State<NewsTabScreen> {
  String maintitle = "News";
  List<News> newsList = <News>[];
  String status = "Loading...";
  @override
  void initState() {
    super.initState();
    loadNews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Column(children: [
        const Text(
          "MyNelayan News",
          style: TextStyle(fontSize: 24),
        ),
        newsList.isEmpty
            ? Center(child: Text(status))
            : Expanded(
                child: ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              (index + 1).toString(),
                            ),
                          ),
                          title: Text(
                            newsList[index].newsTitle.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            truncateString(
                                newsList[index].newsDetail.toString()),
                            textAlign: TextAlign.justify,
                          ),
                          onTap: () {
                            detailsDialog(index);
                          },
                        ),
                      );
                    }))
      ]),
    );
  }

  void loadNews() {
    http.post(Uri.parse("${MyConfig().SERVER}/mynelayan/php/load_news.php"),
        body: {"userid": widget.user.id}).then((response) {
      //print(response.body);
      log(response.body);
      newsList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['news'].forEach((v) {
            newsList.add(News.fromJson(v));
          });
        } else {
          status = "No news available";
          setState(() {});
        }
        setState(() {});
      }
    });
  }

  String truncateString(String str) {
    if (str.length > 100) {
      str = str.substring(0, 100);
      return "$str...";
    } else {
      return str;
    }
  }

  void detailsDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "News Details",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Text(newsList[index].newsTitle.toString(), style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            Text(
              newsList[index].newsDetail.toString(),
              textAlign: TextAlign.justify,
            )
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
}
