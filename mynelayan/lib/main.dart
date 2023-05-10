import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyNelayan',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.aBeeZeeTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
