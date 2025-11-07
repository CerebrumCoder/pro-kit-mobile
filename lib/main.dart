import 'package:flutter/material.dart';
import 'package:pro_kit/screen/base.dart';

void main() {
  runApp(const ProKitApp());
}

// Ini hanya run BasePage sebagai home page dari aplikasi Pro Kit.
class ProKitApp extends StatelessWidget {
  const ProKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProKit App',
      debugShowCheckedModeBanner: false,
      home: BasePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(secondary: Colors.greenAccent[400]),
      ),
    );
  }
}



