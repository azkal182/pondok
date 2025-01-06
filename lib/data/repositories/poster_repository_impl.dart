import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../domain/entities/poster.dart';
import '../../domain/repositories/poster_repository.dart';
import '../datasource/remote/poster_remote_datasource.dart';

class PosterRepositoryImpl implements PosterRepository {
  final PosterRemoteDataSource remoteDataSource;

  PosterRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Poster>>> fetchPosters() async {
    try {
      final posters = await remoteDataSource.fetchPosters();
      return Right(posters);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
