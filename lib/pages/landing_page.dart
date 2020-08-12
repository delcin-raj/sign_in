import 'package:flutter/material.dart';
import 'package:sign_in/pages/home_page.dart';
import 'package:sign_in/pages/sign_in/sign_in_page.dart';
import 'package:sign_in/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;
  LandingPage({@required this.auth});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        //initialData: ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
              );
            } else {
              return MaterialApp(
                home: HomePage(
                  auth: auth,
                ),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
