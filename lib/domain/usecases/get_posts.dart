// lib/domain/usecases/get_posts.dart
import 'package:dartz/dartz.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';
import '../../core/errors/failure.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.fetchPosts();
  }
}
