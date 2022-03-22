import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:real_time_chat_app/view/authentication/service/authentication_service.dart';

import '../../../core/constants/navigation/routes.dart';
import '../../../core/controllers/login/login_controllers.dart';
import '../../../core/init/navigation/navigation_service.dart';

class Authentication implements AuthBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LoginControllers _controller = Get.put(LoginControllers());

  Future<User?> get currentUser async {
    var _user = await _auth.currentUser;
    return _user;
  }

  void _createNewUserInFirestore(String? username, String? email) async {
    final User? user = await currentUser;
    final CollectionReference<Map<String, dynamic>> usersRef =
        FirebaseFirestore.instance.collection('users');
    usersRef.doc(user?.uid).set({
      'id': user?.uid,
      'email': user?.email,
      'username': username,
    });

    /*Map<String, dynamic> newuser = <String, dynamic>{};

    newuser['username'] = username;
    newuser['email'] = email;

    await _firestore.collection('users').add(newuser);*/
  }

  @override
  //Stream<User?> authStateChanges() {
  Stream<User?> authStateChanges() {
    var changes = _auth.authStateChanges();
    changes.listen((User? user) {
      if (user == null) {
        //print('User is currently signed out!');
        debugPrint('User is currently signed out!');
        _controller.signedinController.value = false;
        debugPrint(_controller.signedinController.value.toString());
        /*NavigationService.instance
            .navigateToPage(path: logInPageRoute, data: '_');*/
      } else {
        debugPrint('User is signed in!');
        _controller.signedinController.value = true;
        debugPrint(_controller.signedinController.value.toString());
        /*NavigationService.instance
            .navigateToPage(path: homePageRoute, data: '_');*/
        debugPrint(user.email.toString());
      }
    });
    return changes;
  }

  @override
  Future<void> checkEmailVerified(
      BuildContext context /*, Timer timer*/) async {
    final User? user = await currentUser;
    await user?.reload();
    final User? signedInUser = user;

    if (!signedInUser!.emailVerified) {
      await signedInUser.sendEmailVerification();

      debugPrint("Verification email sent");

      // show flushbar
      customFlushbar(context,
          'You have successfully registered. \n Please verify your account');
    } else if (signedInUser != null && signedInUser.emailVerified) {
      //timer.cancel();
      NavigationService.instance
          .navigateToPage(path: signUpPageRoute, data: '_');
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // TODO:: değiştirilebilir şuanlık login viewa gidilir.
          builder: (context) => const HomePage(),
        ),
      );*/
    } else {
      debugPrint(
          '??Kullanıcının maili onaylanmıştır. İlgili sayfaya gidebilirsiniz.');
    }
  }

  Flushbar<dynamic> customFlushbar(BuildContext context, String message) {
    return Flushbar(
      message: message,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.blueGrey,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      isDismissible: true,
      messageSize: 16.5,
    )..show(context);
  }

  @override
  Future<void> confirmSignOut(BuildContext context) {
    // TODO: implement confirmSignOut
    throw UnimplementedError();
  }

  //@override
  //Future<User?> createUserWithEmailAndPassword(
  @override
  Future<void> createUserWithEmailAndPassword(
      {required BuildContext context,
      required String username,
      required String email,
      required String password}) async {
    try {
      var userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {value.user?.updateDisplayName(username)});

      _createNewUserInFirestore(username, email);

      checkEmailVerified(context);

      //_showVerifyEmailDialog(context);

      //checkEmailVerified(context);

      //return userCredential.user;
    } catch (e) {
      // TODO::
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<void> resetPassword(BuildContext context, String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<User?> signInAnonymously() {
    // TODO: implement signInAnonymously
    throw UnimplementedError();
  }

  @override
  Future<bool?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint(userCredential.toString());

      if (userCredential.user!.emailVerified) {
        // TODO:: mesajlaşma bölümüne geç
        return true;
        print('Başarıyla giriş yapıldı');
      } else {
        _showVerifyEmailDialog(context, userCredential);
        return false;
      }
    } catch (e) {
      // TODO:: alert dialog giriş yapılamadı

      customFlushbar(
          context, 'Email or Password is incorrect please try again');
      return false;

      debugPrint(e.toString());
    }
    /*final UserCredential userCredential = await _auth.signInWithCredential(
      EmailAuthProvider.credential(
        email: email,
        password: password,
      ),
    );*/
    //return userCredential.user;
  }

  @override
  Future<User?> signInWithGoogle(BuildContext context) async {
    //FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);

        user = userCredential.user;

        _createNewUserInFirestore(user?.displayName, user?.email);
        NavigationService.instance
            .navigateToPage(path: homePageRoute, data: '_');
        //
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // TODO:: Show already signed in snackbar
        try {
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);

          user = userCredential.user;

          _createNewUserInFirestore(user?.displayName, user?.email);
          NavigationService.instance
              .navigateToPage(path: homePageRoute, data: '_');
          //
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            customFlushbar(context,
                'The account already exists with a different credential.');
          } else if (e.code == 'invalid-credential') {
            customFlushbar(context,
                'Error occurred while accessing credentials. Try again.');
          }
        } catch (e) {
          customFlushbar(
              context, 'Error occurred using Google Sign-In. Try again.');
        }
      }
    }
    return user;
  }

  Future<void> signOutGoogle({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      customFlushbar(context, 'Error signing out. Try again.');
    }
  }

  @override
  Future<void> signOut() async {
    /*try {
      // TODO:: getx kullan
      final AuthBase auth = Provider.of<AuthBase>(
        context,
        listen: false,
      );
      await auth.signOut();
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LandingPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      print(
        e.toString(),
      );
    }*/
    await _auth.signOut();
  }

  void _showVerifyEmailDialog(
      BuildContext context, UserCredential userCredential) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Verify your account"),
          content:
              const Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            TextButton(
              child: const Text("Resend verification email"),
              onPressed: () {
                Navigator.of(context).pop();

                userCredential.user?.sendEmailVerification();
                //_resendVerifyEmail();
              },
            ),
            TextButton(
              child: const Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("Verify your account"),
          content:
              const Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            TextButton(
              child: const Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
