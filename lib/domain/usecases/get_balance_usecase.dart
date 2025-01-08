import 'package:dartz/dartz.dart';
import 'package:pondok/core/errors/failure.dart';
import 'package:pondok/data/models/balance_model.dart';
import 'package:pondok/domain/repositories/balance_repository.dart';

class GetBalanceUsecase {
  final BalanceRepository repository;

  GetBalanceUsecase(this.repository);

  Future<Either<Failure, BalanceModel>> call() async {
    return await repository.getBalance();
  }
}
