import 'package:flutter/material.dart';
import 'package:sign_in/common_widgets/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    String text,
    Color color: Colors.white,
    Color textColor: Colors.black87,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          onPressed: onPressed,
        );
}

class SignInButtonLogo extends CustomRaisedButton {
  SignInButtonLogo({
    @required String logoAddress, // because assets can't be null
    String text,
    Color color: Colors.white,
    Color textColor: Colors.black87,
    VoidCallback onPressed,
  })  : assert(text != null && logoAddress != null),
        super(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset(logoAddress),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            Container()
          ]),
          color: color,
          onPressed: onPressed,
        );
}
