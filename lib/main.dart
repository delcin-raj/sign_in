import 'package:flutter/material.dart';
import 'package:sign_in/pages/landing_page.dart';
import 'package:sign_in/services/auth.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      title: 'Sign_In',
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
