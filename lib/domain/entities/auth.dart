import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final UserCredentialsEntity userCredentials;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.userCredentials,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, userCredentials];
}

class UserCredentialsEntity extends Equatable {
  final int id;
  final String idSantri;
  final String noRekening;
  final String nis;
  final String nama;
  final String username;
  final String level;
  final int iat;
  final int exp;

  const UserCredentialsEntity({
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

  @override
  List<Object?> get props => [
        id,
        idSantri,
        noRekening,
        nis,
        nama,
        username,
        level,
        iat,
        exp,
      ];
}
