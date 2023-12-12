import 'package:contact_demo/data/repositories/auth_firebase.dart';
import 'package:contact_demo/providers/login.dart';
import 'package:contact_demo/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  final Widget? child;
  const AuthScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;

    return StreamBuilder(
      stream: AuthFirebase.authChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData && (routeName != '/' || routeName != '/register')) {
          return ChangeNotifierProvider<LoginProvider>(
            create: (_) => LoginProvider(),
            child: const LoginScreen(),
          );
        }
        return child ?? const Placeholder();
      },
    );
  }
}
