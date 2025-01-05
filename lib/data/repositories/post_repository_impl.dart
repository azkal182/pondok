// lib/data/repositories/post_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:pondok/data/datasource/remote/post_datasource.dart';
import 'package:pondok/domain/repositories/post_repository.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/post.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Post>>> fetchPosts() async {
    try {
      final posts = await remoteDataSource.fetchPosts();
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
