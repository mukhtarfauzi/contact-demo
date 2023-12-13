import 'package:contact_demo/providers/auth_firebase.dart';
import 'package:contact_demo/view/theme/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  void checkUserCredential() async {
    Provider.of<AuthFirebaseProvider>(context, listen: false).authStateChanges.firstWhere((currentUser){
        if(currentUser != null) {
          Navigator.pushReplacementNamed(context, '/home');
          return true;
        }
        return false;
    }).timeout(Durations.extralong4, onTimeout: () {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkUserCredential();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logo),
          Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
