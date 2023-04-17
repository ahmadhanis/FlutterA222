import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController voltageEditingController = TextEditingController();
  TextEditingController currentEditingController = TextEditingController();
  TextEditingController resistanceEditingController = TextEditingController();
  double ohm = 0.0;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("OHMS Calculator"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/ohms.png',
                  scale: 3.5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                  child: Column(children: [
                    TextField(
                      controller: voltageEditingController,
                      decoration: InputDecoration(
                          hintText: "Voltage (V)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: currentEditingController,
                      decoration: InputDecoration(
                          hintText: "Current (I) Amp",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // TextField(
                    //   controller: resistanceEditingController,
                    //   decoration: InputDecoration(
                    //       hintText: "Resistance (R)",
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10.0))),
                    //   keyboardType: const TextInputType.numberWithOptions(),
                    // ),
                    IconButton(
                      iconSize: 128,
                        onPressed: onPressed,
                        icon: const Icon(Icons.calculate)),
                    // ElevatedButton(
                    //     onPressed: onPressed, child: const Text("Calculate")),
                    Text(
                      "Result $ohm ohm",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ]),
                )
              ],
            ),
          ),
        ));
  }

  void onPressed() {
    if (voltageEditingController.text == "" ||
        currentEditingController.text == "") {
      player.play(AssetSource("sounds/error.wav"));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("ERROR"),
            content: Icon(Icons.error, size: 64),
          );
        },
      );
      return;
    }
    double voltage = double.parse(voltageEditingController.text);
    double ampere = double.parse(currentEditingController.text);
    //double resistance = double.parse(resistanceEditingController.text);
    ohm = voltage / ampere;
    setState(() {});
    player.play(AssetSource("sounds/shock.wav"));
  }
}
