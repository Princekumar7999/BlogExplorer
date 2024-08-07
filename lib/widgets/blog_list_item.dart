

import 'package:flutter/material.dart';
import '../models/blog.dart';

class BlogListItem extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const BlogListItem({
    Key? key,
    required this.blog,
    required this.onTap,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        blog.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(blog.title),
      trailing: IconButton(
        icon: Icon(
          blog.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: blog.isFavorite ? Colors.red : null,
        ),
        onPressed: onFavoriteToggle,
      ),
      onTap: onTap,
    );
  }
}