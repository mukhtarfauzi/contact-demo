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

  void checkUserCredential() {
    final currentUser = Provider.of<AuthFirebaseProvider>(context, listen: false).currentUser;
    if(currentUser != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
    Navigator.pushReplacementNamed(context, '/login');
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
      body: Center(
        child: Image.asset(logo),
      ),
    );
  }
}
