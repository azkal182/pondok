import 'package:equatable/equatable.dart';

class Poster extends Equatable {
  final int id;
  final String description;
  final String url;
  final DateTime createdAt;
  final bool publish;

  Poster({
    required this.id,
    required this.description,
    required this.url,
    required this.createdAt,
    required this.publish,
  });

  @override
  List<Object?> get props => [id, description, url, createdAt, publish];
}
