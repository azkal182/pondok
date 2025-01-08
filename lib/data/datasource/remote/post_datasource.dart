import 'package:dio/dio.dart';
import 'package:pondok/core/constants/app_config.dart';
import 'package:pondok/core/network/dio_provider.dart';
import 'package:pondok/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<List<PostModel>> fetchPosts() async {
    final Dio client = DioProvider.publicDio;
    final response = await client.get(
        '${AppConfig.baseUrlAmtsilatiPusat}/wp-json/wp/v2/posts',
        queryParameters: {'_embed': true, 'per_page': 5});
    final List data = response.data;
    return data.map((post) => PostModel.fromJson(post)).toList();
  }
}
