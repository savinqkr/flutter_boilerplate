import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../models/post.model.dart';
import '../services/post.service.dart';

class AllPostsScreen extends HookWidget {
  const AllPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL POSTS'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Get.isDarkMode
            ? const Icon(Icons.sunny)
            : const Icon(Icons.dark_mode),
        onPressed: () {
          Get.isDarkMode
              ? Get.changeThemeMode(ThemeMode.light)
              : Get.changeThemeMode(ThemeMode.dark);
        },
      ),
      body: Center(
        child: FutureBuilder<List<PostModel>>(
          future: PostService().getAllPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available.');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return ListTile(
                    leading: Text(
                      '${post.postId}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      post.postTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    subtitle: Text(post.postBody),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
