import '../repositories/auth_repository.dart';

class ClearAuthDataUsecase {
  final AuthRepository repository;

  ClearAuthDataUsecase(this.repository);

  Future<void> call() async {
    await repository.clearAuthData();
  }
}
