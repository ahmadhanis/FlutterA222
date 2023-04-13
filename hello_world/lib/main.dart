import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double result = 0.0;
  TextEditingController numactrl = TextEditingController();
  TextEditingController numbctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Card(
            elevation: 16,
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(32),
              child: Column(children: [
                const Text(
                  "My Awesome Calculator",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      hintText: "First Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  controller: numactrl,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      hintText: "Second Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  controller: numbctrl,
                ),
                ElevatedButton(
                    onPressed: onPressed("+"), child: const Text("+"))
              ]),
            ),
          ),
        ),
      ),
    );
  }

  onPressed(String s) {}
}
