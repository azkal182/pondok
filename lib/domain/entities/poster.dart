// lib/domain/entities/post.dart
import 'package:equatable/equatable.dart';

class Poster extends Equatable {
  final int id;
  final String description;
  final String url;
  final String path;
  final DateTime created_at;
  final bool publish;

  const Poster({
    required this.id,
    required this.description,
    required this.url,
    required this.path,
    required this.created_at,
    required this.publish,
  });

  Poster copyWith({
    int? id,
    String? description,
    String? url,
    String? path,
    DateTime? created_at,
    bool? publish,
  }) {
    return Poster(
      id: id ?? this.id,
      description: description ?? this.description,
      url: url ?? this.url,
      path: path ?? this.path,
      created_at: created_at ?? this.created_at,
      publish: publish ?? this.publish,
    );
  }

  @override
  List<Object> get props => [id, description,url, path, created_at, publish];
}
