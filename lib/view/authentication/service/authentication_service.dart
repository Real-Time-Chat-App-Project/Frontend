import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthBase {
  Future<User?> get currentUser;

  Stream<User?> authStateChanges();
  //bool authStateChanges();
  Future<User?> signInWithGoogle(BuildContext context);
  //Future<User?> createUserWithEmailAndPassword({
  Future<void> createUserWithEmailAndPassword({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  });
  Future<void> checkEmailVerified(BuildContext context /*, Timer timer*/);
  Future<bool?> signInWithEmailAndPassword(
      BuildContext context, String email, String password);
  Future<User?> signInAnonymously();
  Future<void> resetPassword(BuildContext context, String email);
  Future<void> confirmSignOut(BuildContext context);
  Future<void> signOut();
}
