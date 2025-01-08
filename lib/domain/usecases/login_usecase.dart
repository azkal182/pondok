import 'package:dartz/dartz.dart';
import 'package:pondok/core/errors/failure.dart';
import 'package:pondok/data/models/auth_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthModel>> call(
      String username, String password) async {
    // Tunggu hasil dari repository.login
    final result = await repository.login(username, password);

    // Periksa apakah hasilnya sukses atau gagal
    return result.fold(
      (failure) async {
        // Jika gagal, kembalikan Left dengan failure
        return Left(failure);
      },
      (authData) async {
        // Jika sukses, simpan data autentikasi
        await repository.saveAuthData(authData);

        // Kembalikan Right dengan authData
        return Right(authData);
      },
    );
  }
}
