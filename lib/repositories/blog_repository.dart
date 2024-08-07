

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hive/hive.dart';
import '../models/blog.dart';

class BlogRepository {
  final String _baseUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String _adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'x-hasura-admin-secret': _adminSecret},
      );

      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = json.decode(response.body)['blogs'];
        final blogs = blogsJson.map((json) => Blog.fromJson(json)).toList();
        
        final box = await Hive.openBox<Blog>('blogs');
        await box.clear();
        await box.addAll(blogs);
        
        return blogs;
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Error fetching blogs: $e');
    }
  }

  Future<void> toggleFavorite(Blog blog) async {
    final box = await Hive.openBox<Blog>('blogs');
    blog.isFavorite = !blog.isFavorite;
    await box.put(blog.id, blog);  
  }
}