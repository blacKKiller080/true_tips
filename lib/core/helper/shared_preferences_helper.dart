import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:true_tips_mobile/core/models/entities/user_entity.dart';

class SharedPreferencesHelper {
  static const String _tokenKey = "token";
  static const String _userKey = "user";

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? null;
  }

  static Future<UserEntity?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserEntity? user;
    try {
      String? userJson = prefs.getString(_userKey);
      user = UserEntity.fromJson(jsonDecode(userJson!));
    } catch (e) {
      user = null;
    }
    return user;
  }

  static Future<void> removeAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
    prefs.remove(_userKey);
  }

  static Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_tokenKey, value);
  }

  static Future<bool> setUser(UserEntity user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonValue;
    try {
      jsonValue = jsonEncode(user);
    } catch (e) {
      jsonValue = "";
    }
    return prefs.setString(_userKey, jsonValue);
  }
}
