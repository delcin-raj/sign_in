import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;
  CustomRaisedButton({
    this.child,
    this.borderRadius: 4.0, // default value
    this.height: 50.0,
    this.color,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        color: color,
        disabledColor: color,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
