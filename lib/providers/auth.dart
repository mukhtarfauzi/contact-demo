import 'package:contact_demo/data/models/auth_model.dart';
import 'package:contact_demo/data/repositories/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class AuthProvider with ChangeNotifier {
  final _box = Hive.box<Auth?>('auth');

  Auth? get auth => _box.get('user');
  set auth(Auth? value) {
    _box.put('user', value);
    notifyListeners();
  }

  bool get isLogin => _box.isNotEmpty && auth != null;

  bool _initialized = false;
  bool get initialized => _initialized;
  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  void logout() {
    auth = null;
    AuthFirebase.logout();
    notifyListeners();
  }
}
