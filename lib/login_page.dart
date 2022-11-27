import 'package:flutter/material.dart';
import './credentials_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final CredentialsStore _credentialsStore = CredentialsStore();
  var remember = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hello",
              style: TextStyle(fontSize: 67, fontWeight: FontWeight.w500),
            ),
            const Text(
              "Sing in to your account",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                hintText: 'Login',
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  10.0,
                  20.0,
                  10.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 69, 68, 67),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: const EdgeInsets.fromLTRB(
                  20.0,
                  10.0,
                  20.0,
                  10.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 69, 68, 67),
                    width: 1.0,
                  ),
                ),
              ),
              obscureText: true,
            ),
            CheckboxListTile(
              value: remember,
              onChanged: (b) {
                setState(() {
                  remember = b ?? false;
                });
              },
              title: const Text('Remember me'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        elevation: 5,
                        shadowColor: const Color.fromARGB(255, 64, 64, 64),
                      ),
                      onPressed: () {
                        final login = loginController.text;
                        final password = passwordController.text;

                        if (login.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                'Заполните все поля!',
                              ),
                            ),
                          );
                          return;
                        }

                        final result = _credentialsStore.login(login, password);

                        switch (result) {
                          case LoginResult.wrongLogin:
                          case LoginResult.wrongPassword:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text(
                                  result.message,
                                ),
                              ),
                            );
                            return;
                          case LoginResult.success:
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     backgroundColor: Colors.greenAccent,
                            //     content: Text(
                            //       result.message,
                            //     ),
                            //   ),
                            // );
                            if (remember) {
                              _credentialsStore.rememberMe();
                            }
                            Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_up');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 5,
                        shadowColor: const Color.fromARGB(255, 64, 64, 64),
                      ),
                      child: const Text('Create Account'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 1));
    final remember = _credentialsStore.wasRemembered();
    if (remember) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
