// data/datasource/local/auth_local_datasource.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData(AuthModel authModel);

  Future<AuthModel?> getAuthData();

  Future<void> clearAuthData();

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _authDataKey = 'authData';

  @override
  Future<void> saveAuthData(AuthModel authModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authDataKey, authModel.toJsonString());
  }

  @override
  Future<AuthModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_authDataKey);
    if (jsonString != null) {
      return AuthModel.fromJsonString(jsonString);
    }
    return null;
  }

  @override
  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authDataKey);
  }

  @override
  Future<String?> getAccessToken() async {
    final authData = await getAuthData();
    return authData?.accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final authData = await getAuthData();
    return authData?.refreshToken;
  }
}
