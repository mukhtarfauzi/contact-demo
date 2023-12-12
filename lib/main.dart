import 'package:contact_demo/data/models/address_model.dart';
import 'package:contact_demo/data/models/contact_list_model.dart';
import 'package:contact_demo/data/models/user_model.dart' show UserAdapter;
import 'package:contact_demo/data/repositories/auth_firebase.dart';
import 'package:contact_demo/providers/login.dart';
import 'package:contact_demo/providers/manage_contact.dart';
import 'package:contact_demo/view/screens/home/home_screen.dart';
import 'package:contact_demo/view/screens/login_screen.dart';
import 'package:contact_demo/view/theme/themes.dart';
import 'package:contact_demo/view/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ContactListAdapter());
  await Hive.openBox<ContactList>('contact');
  await AuthFirebase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<User?>(
      create: (_) => AuthFirebase.currentUser,
      child: MaterialApp(
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
          '/home': (context) =>ChangeNotifierProxyProvider<User, ManageContactProvider>(
            create: (_) => ManageContactProvider(),
            update: (_, auth, model) {
              model!.auth = auth;
              return model;
            },
            child: const HomeScreen(),
          ),
        },
        builder: (context, child) => AuthScreen(child: child),

      ),
    );
  }
}
