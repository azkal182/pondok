import 'package:dartz/dartz.dart';
import '../entities/post.dart';
import '../../core/errors/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> fetchPosts();
}
