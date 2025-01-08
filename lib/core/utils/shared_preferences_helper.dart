// core/helpers/shared_preferences_helper.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/auth_model.dart';

class SharedPreferencesHelper {
  static const String _authDataKey = 'authData';

  /// **Menyimpan data autentikasi ke SharedPreferences**
  /// Konversi `AuthModel` ke JSON string sebelum disimpan.
  static Future<void> saveAuthData(AuthModel authModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authDataKey, authModel.toJsonString());
  }

  /// **Mengambil data autentikasi dari SharedPreferences**
  /// Mengembalikan null jika tidak ada data.
  static Future<AuthModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_authDataKey);
    if (jsonString != null) {
      return AuthModel.fromJsonString(jsonString);
    }
    return null;
  }

  /// **Menghapus data autentikasi dari SharedPreferences**
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authDataKey);
  }

  /// **Mengambil akses token langsung dari SharedPreferences**
  /// Shortcut untuk mendapatkan accessToken.
  static Future<String?> getAccessToken() async {
    final authData = await getAuthData();
    return authData?.accessToken;
  }

  /// **Mengambil refresh token langsung dari SharedPreferences**
  /// Shortcut untuk mendapatkan refreshToken.
  static Future<String?> getRefreshToken() async {
    final authData = await getAuthData();
    return authData?.refreshToken;
  }
}
