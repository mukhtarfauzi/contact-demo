import 'package:contact_demo/providers/auth_firebase.dart';

import 'package:contact_demo/providers/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginProvider extends BaseProvider {
  late AuthFirebaseProvider _auth;
  set auth(AuthFirebaseProvider value) {
    _auth = value;
  }

  String? _email;
  String? _password;

  String? get email => _email;
  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  String? get password => _password;
  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  bool isObscurePassword = true;
  void showPassword() {
    isObscurePassword = false;
    notifyListeners();
  }

  void hidePassword() {
    isObscurePassword = true;
    notifyListeners();
  }

  Future<void> submit({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required Function(String?) onFailure,
  }) async {
    try {
      loadingState = true;
      var response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onFailure(e.message);
    } catch (e) {
      onFailure('Something went wrong');
    } finally {
      loadingState = false;
    }
  }

  Future<void> submitGoogle({
    required VoidCallback onSuccess,
    required Function(String?) onFailure,
  }) async {
    try {
      loadingState = true;
      var response = await _auth.signInWithGoogle();
      if (response != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onFailure(e.message);
    } catch (e) {
      print(e);
      onFailure('Something went wrong');
    } finally {
      loadingState = false;
    }
  }

  Future<void> submitFacebook({
    required VoidCallback onSuccess,
    required Function(String?) onFailure,
  }) async {
    try {
      loadingState = true;
      var response = await _auth.signInWithFacebook();
      if (response != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onFailure(e.message);
    } catch (e) {
      onFailure('Something went wrong');
    } finally {
      loadingState = false;
    }
  }
}
