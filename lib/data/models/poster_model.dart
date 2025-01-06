// lib/data/models/poster_model.dart

import '../../domain/entities/poster.dart';

class PosterModel extends Poster {
  PosterModel({
    required int id,
    required String description,
    required String url,
    required DateTime createdAt,
    required bool publish,
  }) : super(
          id: id,
          description: description,
          url: url,
          createdAt: createdAt,
          publish: publish,
        );

  // Factory method to create PosterModel from JSON
  factory PosterModel.fromJson(Map<String, dynamic> json) {
    return PosterModel(
      id: json['id'],
      description: json['description'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      publish: json['publish'],
    );
  }
}
