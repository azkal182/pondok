
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pondok/data/datasource/remote/post_datasource.dart';
import 'package:pondok/presentation/home/blocs/post_bloc.dart';
import 'core/network/dio_client.dart';
import 'data/repositories/post_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/usecases/get_posts.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  // sl.registerFactory(() => NextPrayerTimeBloc());
  sl.registerFactory(() => PostBloc(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetPosts(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
        () => PostRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
        () => PostRemoteDataSourceImpl(sl()),
  );

  // Core
  sl.registerLazySingleton(() => DioClient(Dio()));
}
