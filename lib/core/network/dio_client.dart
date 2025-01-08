// import 'package:dio/dio.dart';
//
// class DioClient {
//   final Dio _dio;
//
//   DioClient(this._dio) {
//     _dio.options = BaseOptions(
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 5),
//     );
//   }
//
//   Future<Response> get(String path,
//       {Map<String, dynamic>? queryParameters}) async {
//     return await _dio.get(path, queryParameters: queryParameters);
//   }
//
//   Future<Response> post(String path,
//       {dynamic data, Map<String, dynamic>? queryParameters}) async {
//     return await _dio.post(path, data: data, queryParameters: queryParameters);
//   }
//
//   Future<Response> put(String path,
//       {dynamic data, Map<String, dynamic>? queryParameters}) async {
//     return await _dio.put(path, data: data, queryParameters: queryParameters);
//   }
//
//   Future<Response> delete(String path,
//       {dynamic data, Map<String, dynamic>? queryParameters}) async {
//     return await _dio.delete(path,
//         data: data, queryParameters: queryParameters);
//   }
//
//   Future<Response> patch(String path,
//       {dynamic data, Map<String, dynamic>? queryParameters}) async {
//     return await _dio.patch(path, data: data, queryParameters: queryParameters);
//   }
//
//   Future<Response> head(String path,
//       {Map<String, dynamic>? queryParameters}) async {
//     return await _dio.head(path, queryParameters: queryParameters);
//   }
//
//   Future<Response> request(String path,
//       {required String method,
//       dynamic data,
//       Map<String, dynamic>? queryParameters,
//       Options? options}) async {
//     return await _dio.request(path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options ?? Options(method: method));
//   }
// }

import 'package:dio/dio.dart';
import 'package:pondok/core/constants/app_config.dart';
import 'package:pondok/core/utils/shared_preferences_helper.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Tambahkan Authorization hanya untuk private API
          if (dio.options.baseUrl.contains(AppConfig.baseUrlSidafa)) {
            final accessToken = await SharedPreferencesHelper.getAccessToken();
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401 &&
              dio.options.baseUrl.contains(AppConfig.baseUrlSidafa)) {
            // Tangani token refresh hanya untuk private API
            final newToken = await SharedPreferencesHelper.getRefreshToken();
            if (newToken != null) {
              // Ulangi permintaan dengan token baru
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newToken';
              final retryResponse = await dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(retryResponse);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<String?> _getAccessToken() async {
    // Ambil access token (contoh dari Secure Storage)
    // Ganti dengan implementasi Anda
    return null;
  }

  Future<String?> _refreshToken() async {
    // Lakukan refresh token (contoh dari Secure Storage)
    // Ganti dengan implementasi Anda
    try {
      final response = await dio.post('/auth/refresh', data: {
        'refresh_token': await _getRefreshToken(),
      });
      final newAccessToken = response.data['access_token'];
      // Simpan token baru (contoh ke Secure Storage)
      return newAccessToken;
    } catch (e) {
      return null; // Tangani kegagalan refresh token
    }
  }

  Future<String?> _getRefreshToken() async {
    // Ambil refresh token
    return null; // Ganti dengan implementasi Anda
  }
}
