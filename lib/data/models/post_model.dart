// lib/data/models/post_model.dart
import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.thumbnail,
    required super.title,
    required super.overview,
    required super.content,
    required super.date,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      thumbnail: json['_embedded']?["wp:featuredmedia"]?[0]?["media_details"]
              ?["sizes"]?["thumbnail"]?["source_url"] ??
          "https://amtsilatipusat.net/wp-content/uploads/2024/09/bckrnd.jpg",
      title: json['title']['rendered'],
      overview: json['excerpt']['rendered'],
      content: json['content']['rendered'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'thumbnail': thumbnail,
        'title': title,
        'overview': overview,
        'content': content,
        'date': date.toIso8601String(),
      };
}
