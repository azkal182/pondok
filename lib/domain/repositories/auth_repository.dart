import 'package:dartz/dartz.dart';
import 'package:pondok/core/errors/failure.dart';
import 'package:pondok/data/models/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> login(String username, String password);

  Future<void> saveAuthData(AuthModel authModel);

  Future<AuthModel?> getAuthData();

  Future<void> clearAuthData();

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();
}
