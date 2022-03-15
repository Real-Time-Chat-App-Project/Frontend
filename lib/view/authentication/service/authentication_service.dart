import 'package:firebase_auth/firebase_auth.dart';

// TODO:: EmailAuhenticationService ve GoogleAuthenticationService'i abstract classa bağla.
//
abstract class IAuthenticationService {
  //
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static void authenticationWithEmailState() {}

  static Future<User?> signInWithGoogle() async {}

  static Future<void> signOut() async {}
}
