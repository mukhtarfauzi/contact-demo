import 'package:contact_demo/data/models/address_model.dart';
import 'package:contact_demo/data/models/contact_list_model.dart';
import 'package:contact_demo/data/models/user_model.dart' show UserAdapter;
import 'package:contact_demo/firebase_options.dart';
import 'package:contact_demo/providers/auth_firebase.dart';
import 'package:contact_demo/providers/login.dart';
import 'package:contact_demo/providers/manage_contact.dart';
import 'package:contact_demo/providers/register.dart';
import 'package:contact_demo/view/screens/home/home_screen.dart';
import 'package:contact_demo/view/screens/login_screen.dart';
import 'package:contact_demo/view/screens/register_screen.dart';
import 'package:contact_demo/view/theme/themes.dart';
import 'package:contact_demo/view/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ContactListAdapter());
  await Hive.openBox<ContactList>('contact');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthFirebaseProvider>(
      create: (_) => AuthFirebaseProvider(FirebaseAuth.instance),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: Themes.lightFlex,
        darkTheme: Themes.darkFlex,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthScreen(),
          '/login': (context) =>
              ChangeNotifierProxyProvider<AuthFirebaseProvider, LoginProvider>(
                create: (_) => LoginProvider(),
                update: (_, auth, model) {
                  model!.auth = auth;
                  return model;
                },
                child: const LoginScreen(),
              ),
          '/register': (context) =>
              ChangeNotifierProxyProvider<AuthFirebaseProvider, RegisterProvider>(
                create: (_) => RegisterProvider(),
                update: (_, auth, model) {
                  model!.auth = auth;
                  return model;
                },
                child: const RegisterScreen(),
              ),
          '/home': (context) =>
              ChangeNotifierProxyProvider<AuthFirebaseProvider, ManageContactProvider>(
                create: (_) => ManageContactProvider(),
                update: (_, auth, model) {
                  model!.auth = auth;
                  return model;
                },
                child: const HomeScreen(),
              ),
        },
      ),
    );
  }
}
