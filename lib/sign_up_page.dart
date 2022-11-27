import 'package:flutter/material.dart';
import './credentials_store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final loginController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordAgainController = TextEditingController();

  final CredentialsStore _credentialsStore = CredentialsStore();

  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String passwordUser = "";

  @override
  void initState() {
    super.initState();
    firstName = CredentialsStore().getUserFirstname() ?? '';
    lastName = CredentialsStore().getUserLastname() ?? '';
    email = CredentialsStore().getUserEmail() ?? '';
    phoneNumber = CredentialsStore().getUserPhone() ?? '';
    passwordUser = CredentialsStore().getUserPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordAgainController,
              decoration: InputDecoration(
                hintText: 'Password again',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 130,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    elevation: 5,
                    shadowColor: const Color.fromARGB(255, 64, 64, 64),
                  ),
                  onPressed: () async {
                    final login = loginController.text;
                    final password = passwordController.text;
                    final passwordAgain = passwordAgainController.text;

                    if (password != passwordAgain) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            'Пароли не совпадают!',
                          ),
                        ),
                      );
                      return;
                    }

                    final success =
                        await _credentialsStore.signUp(login, password);
                    if (success) {
                      await CredentialsStore().deleteUserFirstname();
                      setState(() {
                        firstName = '';
                      });
                      await CredentialsStore().deleteUserLastname();
                      setState(() {
                        lastName = '';
                      });
                      await CredentialsStore().deleteUserEmail();
                      setState(() {
                        email = '';
                      });
                      await CredentialsStore().deleteUserPhone();
                      setState(() {
                        phoneNumber = '';
                      });
                      await CredentialsStore().deleteUserPassword();
                      setState(() {
                        passwordUser = '';
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            'Такой пользователь уже существует!',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
