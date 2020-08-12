import 'package:flutter/material.dart';
import 'package:sign_in/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  HomePage({@required this.auth});
  Future<void> _signOut() async {
    // awaits suspends execution until the future is served
    try {
      await auth.signOut();
    } on Exception catch (e) {
      // snackbar should come here
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HomePage',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        actions: [
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
