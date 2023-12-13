import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Notes: This class is for make sure all auth call always using same instance
// grouping all type method calling from Firebase Auth Service
// Be represented as a provider to handle auth
class AuthFirebaseProvider extends ChangeNotifier {
  final FirebaseAuth repository;
  AuthFirebaseProvider(this.repository);
  
  Stream<User?> get authStateChanges => repository.authStateChanges();

  void setAuthPersist() async {
    await repository.setPersistence(Persistence.LOCAL);
  }

  Future<UserCredential> createUser(
      {required String email, required String password}) async {
    return await repository.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await repository.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth?.accessToken != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await repository.signInWithCredential(credential);
    }
    return null;
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
      return await repository.signInWithCredential(credential);
    }
    return null;
  }

  User? get currentUser => repository.currentUser;

  Future logout() => repository.signOut();
}
