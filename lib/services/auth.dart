import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;
  // we can add email and password information here
  User({@required this.uid});
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  // Future<User> currentUser();
  Future<void> signInAnonymously();
  Future<void> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  // refactoring
  final _firebasAuth = FirebaseAuth.instance;

  @override
  Stream<User> get onAuthStateChanged {
    return _firebasAuth.onAuthStateChanged.map(_userFromFireBase);
  }

  User _userFromFireBase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(uid: user.uid);
    }
  }

  // Future<User> currentUser() async {
  //   final firebaseUser = await _firebasAuth.currentUser();
  //   return _userFromFireBase(firebaseUser);
  // }

  Future<void> signInAnonymously() async {
    await _firebasAuth.signInAnonymously();
  }

  /*** Google sign in ***/
  Future<void> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        await _firebasAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
      } else {
        throw PlatformException(
          code: 'ERROR_ACCESS_AND_IDTOKEN_MISSING',
          message: 'Sign in Aborter by user',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in Aborter by user',
      );
    }
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn?.signOut();
    await _firebasAuth.signOut();
  }
}
