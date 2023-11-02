import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.model.dart';

class PostService {
  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final jsonData = json.decode(response.body);
      jsonData.forEach((post) {
        posts.add(PostModel.fromJson(post));
      });
    } catch (error) {
      throw Exception(error);
    }
    return posts;
  }

  Future<PostModel?> getPostById(int postId) async {
    if (postId < 1 || postId > 100) {
      return null;
    }
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));
      PostModel post = PostModel.fromJson(json.decode(response.body));
      return post;
    } catch (error) {
      throw Exception(error);
    }
  }
}
