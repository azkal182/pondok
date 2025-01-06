// lib/domain/entities/post.dart
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String thumbnail;
  final String title;
  final String overview;
  final String content;
  final DateTime date;

  const Post({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.overview,
    required this.content,
    required this.date,
  });

  Post copyWith({
    int? id,
    String? title,
    String? overview,
    String? content,
    DateTime? date,
    String? thumbnail,
  }) {
    return Post(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [id, thumbnail, title, overview, content, date];
}
