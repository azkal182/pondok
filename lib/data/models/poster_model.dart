// lib/data/models/poster_model.dart

import '../../domain/entities/poster.dart';

class PosterModel extends Poster {
  PosterModel({
    required super.id,
    required super.description,
    required super.url,
    required super.createdAt,
    required super.publish,
  });

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
