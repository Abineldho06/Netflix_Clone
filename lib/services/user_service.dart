import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static String _emailkey = "email";
  static String _passwordkey = "password";
  static String _isloginkey = "is_login";
  static String _issubscribtionkey = "is_subscription";

  Future<void> saveuserdetails({
    required String email,
    required String password,
  }) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(_emailkey, email);
    pref.setString(_passwordkey, password);
    pref.setBool(_isloginkey, true);
  }

  Future<void> savesubscription() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(_issubscribtionkey, true);
  }

  Future<bool?> islogin() async {
    final pref = await SharedPreferences.getInstance();

    if (pref.containsKey(_isloginkey)) {
      return pref.getBool(_isloginkey);
    } else {
      return false;
    }
  }

  Future<bool?> isSubscription() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(_issubscribtionkey)) {
      return pref.getBool(_issubscribtionkey);
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(_emailkey);
    pref.remove(_passwordkey);
    pref.remove(_isloginkey);
  }
}
