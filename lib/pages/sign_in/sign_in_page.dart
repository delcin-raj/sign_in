import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/common_widgets/platform_exception_alert_dialog.dart';
import 'package:sign_in/pages/sign_in/emai_sign_in_page.dart';
import 'package:sign_in/pages/sign_in/sign_in_button.dart';
import 'package:sign_in/services/auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(title: 'Sign In failed', exception: exception)
        .show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    // awaits suspends execution until the future is served
    try {
      setState(() => _isLoading = true);
      // Get a firebase anonymous
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      // snackbar should come here
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    } finally {
      if (this.mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      await auth.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
    if (this.mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In Page'),
        elevation: 4.0,
      ),
      // Is is a good idea to put anything inside a container
      body: _isLoading
          ? Center(
              child: SizedBox(height: 50.0, child: CircularProgressIndicator()),
            )
          : _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget display(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
          height: 50.0, child: Center(child: CircularProgressIndicator()));
    } else {
      return _buildContent(context);
    }
  }

  Widget _buildContent(BuildContext context) {
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
            onPressed: () => _signInWithGoogle(context),
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
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
