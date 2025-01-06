import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/poster.dart';

abstract class PosterRepository {
  /// Mengambil daftar poster dari sumber data (remote atau local).
  /// Mengembalikan [List<Poster>] jika berhasil atau [Failure] jika ada kesalahan.
  Future<Either<Failure, List<Poster>>> fetchPosters();
}
