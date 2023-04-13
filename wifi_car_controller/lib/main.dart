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
  String operation = "Stop";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: Scaffold(
        appBar: AppBar(title: const Text("WiFi Car Controller")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(20)),
                height: 180,
                width: 350,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () {
                              onPressed("Forward");
                            },
                            child: const Text("Forward")),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () {
                                  onPressed("Left");
                                },
                                child: const Text("Left")),
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () {
                                  onPressed("Stop");
                                },
                                child: const Text("Stop")),
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () {
                                  onPressed("Right");
                                },
                                child: const Text("Rigth")),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () {
                              onPressed("Reverse");
                            },
                            child: const Text("Reverse")),
                      )
                    ]),
              ),
              Text(
                operation,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed(String s) {
    operation = s;
    setState(() {});
  }
}
