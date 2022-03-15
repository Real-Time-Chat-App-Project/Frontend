import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> logIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    //return user.user;
  }

  // TODO:: username ve mail bilgisini firestore'a kaydet. Ama direkt burada yapma firestore için ayrı bir class oluştur.
  // TODO:: yukarıdaki _firestore tanımlamasını da kaldır oradan.
  static void signUp(String username, String email, String password) async {
    ///
    /// TODO:: email email formatına uygun yazılmamış olursa snackbar yada box göster
    ///
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      var _user = userCredential.user;

      // TODO:: Verification emailin onaylanmasını beklet ve kullanıcıyı yönlendir gerekirse.
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

  static void authenticationWithEmailState() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        //print('User is currently signed out!');
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
  }
}
