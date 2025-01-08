import 'package:dartz/dartz.dart';
import 'package:pondok/data/datasource/remote/auth_remote_datasource.dart';
import 'package:pondok/data/models/auth_model.dart';
import 'package:pondok/domain/repositories/auth_repository.dart';
import '../../core/errors/failure.dart';
import '../datasource/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, AuthModel>> login(
      String username, String password) async {
    try {
      final auth = await remoteDataSource.login(username, password);
      return Right(auth);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> saveAuthData(AuthModel authModel) async {
    await localDataSource.saveAuthData(authModel);
  }

  @override
  Future<AuthModel?> getAuthData() async {
    return await localDataSource.getAuthData();
  }

  @override
  Future<void> clearAuthData() async {
    await localDataSource.clearAuthData();
  }

  @override
  Future<String?> getAccessToken() async {
    return await localDataSource.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await localDataSource.getRefreshToken();
  }
}
