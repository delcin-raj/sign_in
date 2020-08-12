import 'package:flutter/material.dart';
import 'package:sign_in/pages/sign_in/sign_in.dart';
import 'package:sign_in/services/auth.dart';

class SignInPage extends StatelessWidget {
  final AuthBase auth;

  SignInPage({@required this.auth});

  Future<void> _signInAnonymously() async {
    // awaits suspends execution until the future is served
    try {
      // Get a firebase anonymous
      await auth.signInAnonymously();
    } on Exception catch (e) {
      // snackbar should come here
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In Page'),
        elevation: 4.0,
      ),
      // Is is a good idea to put anything inside a container
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    // If we are interested about background color
    // replace Padding with Container
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.0),
          SignInButtonLogo(
            logoAddress: 'assets/images/google-logo.png',
            text: 'Sign In with Google',
            onPressed: _signInWithGoogle,
          ),
          SizedBox(height: 8.0),
          SignInButtonLogo(
            logoAddress: 'assets/images/facebook-logo.png',
            text: 'Sign In with Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign In with Email',
            color: Colors.teal[600],
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign In anonymously',
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }
}
