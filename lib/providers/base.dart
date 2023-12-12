import 'dart:async';

import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  final StreamController<bool> _loginStateChange = StreamController<bool>.broadcast();
  Stream<bool> get loadingStateChange => _loginStateChange.stream;
  bool _loadingState = false;
  bool get loadingState => _loadingState;
  set loadingState(bool state) {
    _loadingState = state;
    _loginStateChange.add(state);
  }
}