import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sign_in/pages/sign_in/email_sign_in_model.dart';
import 'package:sign_in/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel(); // this is not final
  void dispose() {
    _modelController.close();
  }

  // The whole idea is that we make changes to the stream to make the
  // widgets rebuild itself
  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    if (!_modelController.isClosed) {
      _modelController.add(_model);
    }
  }

  Future<void> submit() async {
    // in stateful widget the context is always available
    updateWith(submitted: true, isLoading: true);

    if (_model.formType == EmailSignInFormType.signIn) {
      await auth.signInWithEmailAndPassword(_model.email, _model.password);
    } else {
      await auth.createUserWithEmailAndPassword(_model.email, _model.password);
    }

    updateWith(isLoading: false);
  }

  void toggleFormType() {
    // updating the stream
    // UI changes accordingly
    updateWith(
      isLoading: false,
      email: '',
      password: '',
      submitted: false,
      formType: _model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
    );
  }
}
