import 'package:dio/dio.dart';
import 'package:pondok/core/constants/app_config.dart';
import 'dio_client.dart';

class DioProvider {
  static Dio publicDio = DioClient(
    Dio(
      BaseOptions(
        connectTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 5000),
        headers: {'Content-Type': 'application/json'},
      ),
    ),
  ).dio;

  static Dio privateDio = DioClient(
    Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrlSidafa,
        connectTimeout: Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
        headers: {'Content-Type': 'application/json'},
      ),
    ),
  ).dio;
}
