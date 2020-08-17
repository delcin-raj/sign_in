import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  // stream is exposed to the users
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  // The question is whether the dispose method is automatically called?
  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<void> _signIn(Future<void> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    } finally {}
  }

  Future<void> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<void> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}
