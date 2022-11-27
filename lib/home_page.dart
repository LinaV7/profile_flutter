import 'package:flutter/material.dart';
import 'credentials_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _login = '';
  final CredentialsStore _credentialsStore = CredentialsStore();

  @override
  void initState() {
    super.initState();
    _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              _credentialsStore.forgetRemembered();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hello $_login!',
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 5,
                        shadowColor: const Color.fromARGB(255, 64, 64, 64),
                      ),
                      child: const Text('Profile'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _getLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _login = _credentialsStore.getCurrentLogin();
    });
  }
}
