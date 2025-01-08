import 'package:dartz/dartz.dart';
import 'package:pondok/core/errors/failure.dart';
import 'package:pondok/data/models/auth_model.dart';
import '../repositories/auth_repository.dart';

class GetAuthDataUseCase {
  final AuthRepository repository;

  GetAuthDataUseCase(this.repository);

  Future<AuthModel?> call() async {
    try {
      return await repository.getAuthData();
    } catch (e) {
      return null;
    }
  }
}
