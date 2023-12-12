import 'package:contact_demo/data/repositories/auth_firebase.dart';
import 'package:contact_demo/providers/auth.dart';
import 'package:contact_demo/providers/login.dart';
import 'package:contact_demo/view/screens/home_screen.dart';
import 'package:contact_demo/view/screens/login_screen.dart';
import 'package:contact_demo/view/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthFirebase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.lightFlex,
      darkTheme: Themes.darkFlex,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => ChangeNotifierProvider<LoginProvider>(
              create: (_) => LoginProvider(),
              child: const LoginScreen(),
            ),
        '/home': (context) => const HomeScreen(),
      },

    );
  }
}
