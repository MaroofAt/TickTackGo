import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user/user.dart';

// utils/shared_prefs_helper.dart

const String _userDataKey = 'user_data';
   const String _accessTokenKey = 'access_token';
   const String _refreshTokenKey = 'refresh_token';

   Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

   Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

   Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

   Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }


Future<void> saveUserData(User user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_userDataKey, jsonEncode(user.toJson()));
}

Future<User> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userData = prefs.getString(_userDataKey);
    return User.fromJson(jsonDecode(userData!));

  // return null;
}

Future<void> clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_userDataKey);
}