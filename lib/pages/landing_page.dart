import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/pages/home_page.dart';
import 'package:sign_in/pages/sign_in/sign_in_page.dart';
import 'package:sign_in/services/auth.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        //initialData: ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage();
            } else {
              return MaterialApp(
                home: HomePage(),
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
