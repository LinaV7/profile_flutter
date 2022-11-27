import 'package:shared_preferences/shared_preferences.dart';

class CredentialsStore {
  static SharedPreferences? _prefs;

  CredentialsStore() {
    _initPrefs();
  }

  // ключ для текстового поля profile
  final _keyUserFirstname = 'userfirstname';
  final _keyUserLastname = 'userlastname';
  final _keyUserEmail = 'useremail';
  final _keyUserPhone = 'userphone';
  final _keyUserPassword = 'userpassword';

  // userfirstname
  Future setUserFirstname(String userfirstname) async =>
      await _prefs?.setString(_keyUserFirstname, userfirstname);
  String? getUserFirstname() => _prefs?.getString(_keyUserFirstname);
  Future<bool>? deleteUserFirstname() => _prefs?.remove(_keyUserFirstname);

  // userlastname
  Future setUserLastname(String userlastname) async =>
      await _prefs?.setString(_keyUserLastname, userlastname);
  String? getUserLastname() => _prefs?.getString(_keyUserLastname);
  Future<bool>? deleteUserLastname() => _prefs?.remove(_keyUserLastname);

  // useremail
  Future setUserEmail(String useremail) async =>
      await _prefs?.setString(_keyUserEmail, useremail);
  String? getUserEmail() => _prefs?.getString(_keyUserEmail);
  Future<bool>? deleteUserEmail() => _prefs?.remove(_keyUserEmail);

  // userphone
  Future setUserPhone(String userphone) async =>
      await _prefs?.setString(_keyUserPhone, userphone);
  String? getUserPhone() => _prefs?.getString(_keyUserPhone);
  Future<bool>? deleteUserPhone() => _prefs?.remove(_keyUserPhone);

  // userpassword
  Future setUserPassword(String userpassword) async =>
      await _prefs?.setString(_keyUserPassword, userpassword);
  String? getUserPassword() => _prefs?.getString(_keyUserPassword);
  Future<bool>? deleteUserPassword() => _prefs?.remove(_keyUserPassword);

  Future rememberMe() async {
    await _prefs?.setBool('remember', true);
  }

  bool wasRemembered() {
    return _prefs?.getBool('remember') ?? false;
  }

  Future forgetRemembered() async {
    return await _prefs?.remove('remember');
  }

  String getCurrentLogin() {
    return _prefs?.getString('login') ?? '';
  }

  Future setCurrentLogin(String login) async =>
      await _prefs?.setString('login', login);

  String getCurrentPassword() {
    return _prefs?.getString('password') ?? '';
  }

  Future setCurrentPassword(String password) async =>
      await _prefs?.setString('password', password);

  Future<bool> signUp(String login, String password) async {
    final savedLogin = _prefs?.getString('login');
    if (login == savedLogin) return false;
    await _prefs?.setString('login', login);
    await _prefs?.setString('password', password);
    return true;
  }

  LoginResult login(String login, String password) {
    final savedLogin = _prefs?.getString('login');
    final savedPassword = _prefs?.getString('password');

    if (savedLogin != login) {
      return LoginResult.wrongLogin;
    }

    if (savedLogin != login) {
      return LoginResult.wrongLogin;
    }

    if (savedPassword != password) {
      return LoginResult.wrongPassword;
    }

    return LoginResult.success;
  }

  Future _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  init() {}
}

enum LoginResult {
  wrongLogin('Такого пользователя нет!'),
  wrongPassword('Неверный пароль!'),
  success('Успешная авторизация!'),
  ;

  final String message;

  const LoginResult(this.message);
}
