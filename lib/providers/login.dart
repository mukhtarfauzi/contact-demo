import 'package:contact_demo/data/repositories/auth_firebase.dart';
import 'package:contact_demo/providers/auth.dart' as auth;

import 'package:contact_demo/providers/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginProvider extends BaseProvider {
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
      var response = await AuthFirebase.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.credential != null) {
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
      var response = await AuthFirebase.signInWithGoogle();
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

  Future<void> submitFacebook({
    required VoidCallback onSuccess,
    required Function(String?) onFailure,
  }) async {
    try {
      loadingState = true;
      var response = await AuthFirebase.signInWithFacebook();
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
