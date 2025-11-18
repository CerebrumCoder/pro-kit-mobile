import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:pro_kit/screens/base.dart';
import 'package:pro_kit/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProKitApp());
}

// Ini hanya run BasePage sebagai home page dari aplikasi Pro Kit.
class ProKitApp extends StatelessWidget {
  const ProKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Di wrap dengan Provider yang akan membagikan instance CookieRequest dengan semua komponen yang ada di aplikasi.
    // Package Flutter yang dapat dipakai untuk melakukan kontak dengan web service Django (termasuk operasi GET dan POST)
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },

      child: MaterialApp(
        title: 'ProKit App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(secondary: Colors.greenAccent[400]),
        ),

        home: const LoginPage(),
      ),
    );
  }
}



