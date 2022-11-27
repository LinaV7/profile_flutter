import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'credentials_store.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";

  var _login = '';
  var _password = '';
  final CredentialsStore _credentialsStore = CredentialsStore();

  @override
  void initState() {
    super.initState();

    firstName = CredentialsStore().getUserFirstname() ?? '';
    lastName = CredentialsStore().getUserLastname() ?? '';
    email = CredentialsStore().getUserEmail() ?? '';
    phoneNumber = CredentialsStore().getUserPhone() ?? '';
    password = CredentialsStore().getUserPassword() ?? '';

    _getLoginIn();
    firstName = _login;
    password = _password;
  }

  Future _getLoginIn() async {
    setState(() {
      _login = _credentialsStore.getCurrentLogin();
      _password = _credentialsStore.getCurrentPassword();
    });
  }

  File? image;
  Future pickImage() async {
    try {
      final PickedFile? image =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (image == null) return;
      final File imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red,
              Colors.white,
            ],
          ),
        ),
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/avatar.png'),
                      ),
                    ),
                    child: ClipOval(
                      child: image != null
                          ? Image.file(
                              image!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Text(""),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: MaterialButton(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        pickImage();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: firstName,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Login*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name";
                      }
                      return null;
                    },
                    onChanged: (firstName) =>
                        setState(() => this.firstName = firstName),
                  ),
                  TextFormField(
                    initialValue: lastName,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline),
                      labelText: 'User Name*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your last name";
                      }
                      return null;
                    },
                    onChanged: (lastName) =>
                        setState(() => this.lastName = lastName),
                  ),
                  TextFormField(
                    initialValue: email,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'E-mail Address*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your E-mail";
                      }
                      if (!value.contains('@')) {
                        return "Please enter your E-mail";
                      }
                      return null;
                    },
                    onChanged: (email) => setState(() => this.email = email),
                  ),
                  TextFormField(
                    initialValue: phoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Mobile Number*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your number";
                      }
                      return null;
                    },
                    onChanged: (phoneNumber) =>
                        setState(() => this.phoneNumber = phoneNumber),
                  ),
                  TextFormField(
                    initialValue: password,
                    obscureText: true,
                    obscuringCharacter: password,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: 'Password*',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    onChanged: (password) =>
                        setState(() => this.password = password),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () async {
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Forget',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    }

                    await CredentialsStore().setUserFirstname(firstName);
                    await CredentialsStore().setUserLastname(lastName);
                    await CredentialsStore().setUserEmail(email);
                    await CredentialsStore().setUserPhone(phoneNumber);
                    await CredentialsStore().setUserPassword(password);

                    if (firstName != _login) {
                      _login = firstName;
                      await CredentialsStore().setCurrentLogin(_login);
                    }

                    if (password != _password) {
                      _password = password;
                      await CredentialsStore().setCurrentPassword(_password);
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
