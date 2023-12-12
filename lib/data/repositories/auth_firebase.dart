import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../firebase_options.dart';

// Notes: This repo is for make sure all auth call always using same instance
// grouping all type method calling to Firebase Auth Service
class AuthFirebase {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final authStateChanges = _auth.authStateChanges;

  static init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Notes: only run on debug
    // assert(() {
    //   _auth.useAuthEmulator('localhost', 9099);
    //   return true;
    // }());
  }

  static setAuthPersist() async {
    await _auth.setPersistence(Persistence.LOCAL);
  }

  static Future<UserCredential> createUser(
      {required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth?.accessToken != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  static Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  static Future logout() async {
    _auth.signOut();
  }
}
