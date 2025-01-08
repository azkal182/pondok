import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pondok/core/network/dio_provider.dart';
import 'package:pondok/data/datasource/local/auth_local_datasource.dart';
import 'package:pondok/data/datasource/local/prayer_time_datasorce.dart';
import 'package:pondok/data/datasource/remote/auth_remote_datasource.dart';
import 'package:pondok/data/datasource/remote/balance_remote_datasource.dart';
import 'package:pondok/data/datasource/remote/post_datasource.dart';
import 'package:pondok/data/repositories/auth_repository_impl.dart';
import 'package:pondok/data/repositories/balance_repository_impl.dart';
import 'package:pondok/data/repositories/prayer_time_repository_impl.dart';
import 'package:pondok/domain/repositories/auth_repository.dart';
import 'package:pondok/domain/repositories/balance_repository.dart';
import 'package:pondok/domain/repositories/prayer_time_repository.dart';
import 'package:pondok/domain/usecases/clear_auth_data_usecase.dart';
import 'package:pondok/domain/usecases/get_balance_usecase.dart';
import 'package:pondok/domain/usecases/login_usecase.dart';
import 'package:pondok/presentation/blocs/auth_bloc.dart';
import 'package:pondok/presentation/blocs/balance_bloc.dart';
import 'package:pondok/presentation/pages/home/blocs/post_bloc.dart';
import 'package:pondok/presentation/pages/home/blocs/poster_bloc.dart';
import 'package:pondok/presentation/pages/home/blocs/prayer_times_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/poster_remote_datasource.dart';
import 'data/repositories/post_repository_impl.dart';
import 'data/repositories/poster_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/poster_repository.dart';
import 'domain/usecases/get_posters.dart';
import 'domain/usecases/get_posts.dart';
import 'domain/usecases/get_auth_data_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // shared pref
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // dio provider
  sl.registerLazySingleton<Dio>(() => DioProvider.publicDio,
      instanceName: 'publicDio');
  sl.registerLazySingleton<Dio>(() => DioProvider.privateDio,
      instanceName: 'privateDio');

  // Use Cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => GetPosters(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthDataUseCase(sl()));
  sl.registerLazySingleton(() => ClearAuthDataUsecase(sl()));
  sl.registerLazySingleton(() => GetBalanceUsecase(sl()));

  // Bloc
  sl.registerFactory(() => PostBloc(sl()));
  sl.registerFactory(() => BalanceBloc(sl()));
  sl.registerFactory(() => PosterBloc(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
  sl.registerFactory(() => PrayerTimesBloc(sl())); // Register PrayerTimesBloc

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PosterRepository>(
    () => PosterRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PrayerTimesRepository>(
    () => PrayerTimesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<BalanceRepository>(
    () => BalanceRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PosterRemoteDataSource>(
    () => PosterRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PrayerTimesDataSource>(
    () => PrayerTimesDataSource(),
  );

  sl.registerLazySingleton<BalanceRemoteDataSource>(
    () => BalanceRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      publicDio: sl<Dio>(instanceName: 'publicDio'),
      privateDio: sl<Dio>(instanceName: 'privateDio'),
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
}
