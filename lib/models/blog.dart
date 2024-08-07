

import 'package:hive/hive.dart';

part 'blog.g.dart';

@HiveType(typeId: 0)
class Blog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  bool isFavorite;

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}