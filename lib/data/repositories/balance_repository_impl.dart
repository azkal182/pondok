import 'package:dartz/dartz.dart';
import 'package:pondok/data/datasource/remote/balance_remote_datasource.dart';
import 'package:pondok/data/models/balance_model.dart';
import 'package:pondok/domain/repositories/balance_repository.dart';

import '../../core/errors/failure.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceRemoteDataSource balanceRemoteDataSource;

  BalanceRepositoryImpl(this.balanceRemoteDataSource);

  @override
  Future<Either<Failure, BalanceModel>> getBalance() async {
    try {
      final balance = await balanceRemoteDataSource.getBalance();
      return right(balance);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
