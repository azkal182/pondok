import 'package:dio/dio.dart';
import 'package:pondok/core/constants/app_config.dart';
import 'package:pondok/data/models/balance_model.dart';

import '../../../core/network/dio_provider.dart';

abstract class BalanceRemoteDataSource {
  Future<BalanceModel> getBalance();
}

class BalanceRemoteDataSourceImpl implements BalanceRemoteDataSource {
  @override
  Future<BalanceModel> getBalance() async {
    print("requested");
    final Dio client = DioProvider.privateDio;
    final response =
        await client.get('${AppConfig.baseUrlSidafa}/api/transaksi/getsaldo');
    return BalanceModel.fromJson(response.data['data']);
  }
}
