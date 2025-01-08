// import 'package:pondok/core/constants/app_config.dart';
// import 'package:pondok/core/network/dio_client.dart';
// import 'package:pondok/data/models/auth_model.dart';
//
// abstract class AuthRemoteDatasource {
//   final DioClient client;
//
//   AuthRemoteDatasource(this.client);
//
//   Future<AuthModel> login(String username, String password);
// }
//
// class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
//   AuthRemoteDatasourceImpl(super.client);
//
//   @override
//   Future<AuthModel> login(String username, String password) async {
//     final response = await client.post(
//       '${AppConfig.baseUrlSidafa}/api/auth/login',
//       data: {
//         'username': username,
//         'password': password,
//       },
//     );
//     return AuthModel.fromJson(response.data);
//   }
// }

import 'package:dio/dio.dart';
import 'package:pondok/core/constants/app_config.dart';
import 'package:pondok/core/utils/shared_preferences_helper.dart';
import 'package:pondok/data/models/auth_model.dart';
import '../../../../core/network/dio_provider.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);

  Future<Map<String, dynamic>> fetchUserProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio publicDio;
  final Dio privateDio;

  AuthRemoteDataSourceImpl({
    required this.publicDio,
    required this.privateDio,
  });

  @override
  Future<AuthModel> login(String username, String password) async {
    try {
      final response = await publicDio.post(
        '${AppConfig.baseUrlSidafa}/auth/login',
        data: {'username': username, 'password': password},
      );

      // Parsing response ke AuthModel
      final authModel = AuthModel.fromJson(response.data);

      // Simpan ke SharedPreferences
      await SharedPreferencesHelper.saveAuthData(authModel);

      return authModel;
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.response?.data ?? e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      final response = await privateDio.get('/user/profile');
      return response.data; // Return user profile data
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.response?.data ?? e.message}');
    }
  }
}
