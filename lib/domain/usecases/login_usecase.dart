import 'package:dartz/dartz.dart';
import 'package:pondok/core/errors/failure.dart';
import 'package:pondok/data/models/auth_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthModel>> call(String username, String password) {
    return repository.login(username, password);
  }
}
