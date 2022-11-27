import 'package:flutter/material.dart';
import 'credentials_store.dart';
import './profile.dart';
import './login_page.dart';
import './home_page.dart';
import './sign_up_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CredentialsStore().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/profile': (context) => const MyProfile(),
        '/sign_up': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
