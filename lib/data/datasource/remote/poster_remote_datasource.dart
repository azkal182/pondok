import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/network/dio_client.dart';
import '../../models/poster_model.dart';

// class PosterRemoteDataSource {
//   final http.Client client;
//
//   PosterRemoteDataSource(this.client);
//
//   Future<List<PosterModel>> getPosters() async {
//     final response = await client.get(Uri.parse('https://your-api-endpoint.com/api/poster'));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['data'];
//       return data.map((json) => PosterModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load posters');
//     }
//   }
// }

abstract class PosterRemoteDataSource {
  Future<List<PosterModel>> fetchPosters();
}

class PosterRemoteDataSourceImpl implements PosterRemoteDataSource {
  final DioClient client;

  PosterRemoteDataSourceImpl(this.client);

  @override
  Future<List<PosterModel>> fetchPosters() async {
    // final response = await client.get('https://backoffice-amtsilati-pusat.vercel.app/api/poster');
    // print('API Response: ${response.data}');
    // final List data = response.data['data'];
    // print(response);
    // return data.map((post) => PosterModel.fromJson(post)).toList();
    final response = await client
        .get('https://backoffice-amtsilati-pusat.vercel.app/api/poster');
    if (response.statusCode == 200) {
      if (response.data is Map && response.data.containsKey('data')) {
        final List data = response.data['data'];
        return data.map((post) => PosterModel.fromJson(post)).toList();
      } else {
        throw Exception('Invalid API Response Structure');
      }
    } else {
      throw Exception(
          'Failed to fetch data, status code: ${response.statusCode}');
    }
  }
}
