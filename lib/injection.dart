import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pondok/data/datasource/local/prayer_time_datasorce.dart';
import 'package:pondok/data/datasource/remote/post_datasource.dart';
import 'package:pondok/data/repositories/prayer_time_repository_impl.dart';
import 'package:pondok/domain/repositories/prayer_time_repository.dart';
import 'package:pondok/presentation/home/blocs/post_bloc.dart';
import 'package:pondok/presentation/home/blocs/poster_bloc.dart';
import 'package:pondok/presentation/home/blocs/prayer_times_bloc.dart';
import 'core/network/dio_client.dart';
import 'data/datasource/remote/poster_remote_datasource.dart';
import 'data/repositories/post_repository_impl.dart';
import 'data/repositories/poster_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/poster_repository.dart';
import 'domain/usecases/get_posters.dart';
import 'domain/usecases/get_posts.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => PostBloc(sl()));
  sl.registerFactory(() => PosterBloc(sl()));
  sl.registerFactory(() => PrayerTimesBloc(sl())); // Register PrayerTimesBloc

  // Use Cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => GetPosters(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PosterRepository>(
    () => PosterRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PrayerTimesRepository>(
    () => PrayerTimesRepositoryImpl(sl()), // Register PrayerTimesRepositoryImpl
  );

  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PosterRemoteDataSource>(
    () => PosterRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PrayerTimesDataSource>(
    () => PrayerTimesDataSource(), // Register PrayerTimesDataSource
  );

  // Core
  sl.registerLazySingleton(() => DioClient(Dio()));
}
