import 'package:dartz/dartz.dart';
import 'package:pondok/data/models/balance_model.dart';

import '../../core/errors/failure.dart';

abstract class BalanceRepository {
  Future<Either<Failure, BalanceModel>> getBalance();
}
