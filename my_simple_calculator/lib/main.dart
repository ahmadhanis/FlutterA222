import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController textEditingController = TextEditingController();
  String val = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: const Text("My Calculator")),
        body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      hintText: '',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                )),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: 230,
              width: 300,
              color: Colors.blue,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          onPressed("1");
                        },
                        child: const Text("1")),
                    ElevatedButton(
                        onPressed: () {
                          onPressed("2");
                        },
                        child: const Text("2")),
                    ElevatedButton(
                        onPressed: () {
                          onPressed("3");
                        },
                        child: const Text("3")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          onPressed("4");
                        },
                        child: const Text("4")),
                    ElevatedButton(
                        onPressed: () {
                          onPressed("5");
                        },
                        child: const Text("5")),
                    ElevatedButton(
                        onPressed: () {
                          onPressed("6");
                        },
                        child: const Text("6")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          onPressed("7");
                        },
                        child: const Text("7")),
                    ElevatedButton(
                        onPressed: () {
                          onPressed("8");
                        },
                        child: const Text("8")),
                    ElevatedButton(
                        onPressed: () {
                          onPressed("9");
                        },
                        child: const Text("9")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          onPressed("0");
                        },
                        child: const Text("0")),
                  ],
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }

  void onPressed(String s) {
    val = val + s;
    textEditingController.text = val;
    setState(() {});
  }
}
