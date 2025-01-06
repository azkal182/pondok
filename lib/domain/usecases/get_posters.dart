import 'package:dartz/dartz.dart';
import 'package:pondok/domain/entities/poster.dart';

import '../../core/errors/failure.dart';
import '../repositories/poster_repository.dart';

class GetPosters {
  final PosterRepository repository;

  GetPosters(this.repository);

  Future<Either<Failure, List<Poster>>> call() async {
    return await repository.fetchPosters();
  }
}
