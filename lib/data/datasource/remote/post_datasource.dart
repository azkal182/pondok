// lib/data/datasources/post_remote_datasource.dart
import 'package:pondok/core/network/dio_client.dart';
import 'package:pondok/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient client;

  PostRemoteDataSourceImpl(this.client);

  @override
  Future<List<PostModel>> fetchPosts() async {
    final response = await client.get('posts', queryParameters: {'_embed': true, 'per_page':5});
    final List data = response.data;
    return data.map((post) => PostModel.fromJson(post)).toList();
  }
}
