import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    //return user.user;
  }

  static void signUp(String username, String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      var _user = userCredential.user;

      // email verification
      if (!_user!.emailVerified) {
        await _user.sendEmailVerification();

        debugPrint("Verification email sent");
      } else {
        debugPrint(
            'Kullanıcının maili onaylanmıştır. İlgili sayfaya gidebilirsiniz.');
      }
      debugPrint('ussssserrrerewrsdassd: $username');
      debugPrint(userCredential.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
