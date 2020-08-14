import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sign_in/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'Ok',
        );
  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'Enter a strong password.',
    'ERROR_INVALID_EMAIL': 'Please enter a valid email address',
    'ERROR_EMAIL_ALREADY_IN_USE': 'Email already in use, please login',
    'ERROR_DISABLED': 'Account has been disabled',
    'ERROR_INVALID': 'Email address is invalid',
  };
}
