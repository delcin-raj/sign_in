import 'package:flutter/material.dart';
import 'package:sign_in/pages/sign_in/email_sign_in_form_with_block.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 4.0,
      ),
      // Is is a good idea to put anything inside a container
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: _buildContent(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return EmailSignInFormWithBlock.create(context);
  }
}
