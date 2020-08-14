import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/common_widgets/platform_alert_dialog.dart';
import 'package:sign_in/services/auth.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    // awaits suspends execution until the future is served
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } on Exception catch (e) {
      // snackbar should come here
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
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
            onPressed: () {
              _confirmSignOut(context);
            },
          )
        ],
      ),
    );
  }
}
