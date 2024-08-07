

import 'package:flutter/material.dart';
import '../models/blog.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(blog.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              blog.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: Theme.of(context).textTheme.titleLarge, 
                  ),
                  SizedBox(height: 8),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}