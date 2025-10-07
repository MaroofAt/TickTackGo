
import 'package:shared_preferences/shared_preferences.dart';


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
