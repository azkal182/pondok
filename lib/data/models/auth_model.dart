import 'dart:convert';

import 'package:pondok/domain/entities/auth_entity.dart';

/// Model for Authentication, extending AuthEntity
class AuthModel extends AuthEntity {
  final String accessToken;
  final String refreshToken;
  final UserCredentialsModel userCredentials;

  const AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userCredentials,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
          userCredentials: userCredentials,
        );

  /// Factory method to create an instance from JSON.
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      userCredentials: UserCredentialsModel.fromJson(json['userCredentials']),
    );
  }

  /// Converts the model to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userCredentials': userCredentials.toJson(),
    };
  }

  /// Converts the model to a JSON string.
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Creates an instance from a JSON string.
  static AuthModel fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return AuthModel.fromJson(json);
  }
}

/// Model for User Credentials, extending UserCredentialsEntity
class UserCredentialsModel extends UserCredentialsEntity {
  const UserCredentialsModel({
    required int id,
    required String idSantri,
    required String noRekening,
    required String nis,
    required String nama,
    required String username,
    required String level,
    required int iat,
    required int exp,
  }) : super(
          id: id,
          idSantri: idSantri,
          noRekening: noRekening,
          nis: nis,
          nama: nama,
          username: username,
          level: level,
          iat: iat,
          exp: exp,
        );

  /// Factory method to create an instance from JSON.
  factory UserCredentialsModel.fromJson(Map<String, dynamic> json) {
    return UserCredentialsModel(
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

  /// Converts the model to JSON format.
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
