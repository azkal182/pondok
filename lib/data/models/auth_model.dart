// data/models/auth_model.dart
import 'dart:convert';

class AuthModel {
  final String accessToken;
  final String refreshToken;
  final UserCredentials userCredentials;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userCredentials,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      userCredentials: UserCredentials.fromJson(json['userCredentials']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userCredentials': userCredentials.toJson(),
    };
  }

  // Untuk mengonversi ke string JSON
  String toJsonString() {
    return jsonEncode(this.toJson());
  }

  // Untuk mengonversi dari string JSON
  static AuthModel fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return AuthModel.fromJson(json);
  }
}

class UserCredentials {
  final int id;
  final String idSantri;
  final String noRekening;
  final String nis;
  final String nama;
  final String username;
  final String level;
  final int iat;
  final int exp;

  UserCredentials({
    required this.id,
    required this.idSantri,
    required this.noRekening,
    required this.nis,
    required this.nama,
    required this.username,
    required this.level,
    required this.iat,
    required this.exp,
  });

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      id: json['id'],
      idSantri: json['id_santri'],
      noRekening: json['no_rekening'],
      nis: json['nis'],
      nama: json['nama'],
      username: json['username'],
      level: json['level'],
      iat: json['iat'],
      exp: json['exp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_santri': idSantri,
      'no_rekening': noRekening,
      'nis': nis,
      'nama': nama,
      'username': username,
      'level': level,
      'iat': iat,
      'exp': exp,
    };
  }
}
