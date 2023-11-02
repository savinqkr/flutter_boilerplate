import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/screens/all_posts.screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/route_manager.dart';

import 'screens/search_post.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Boilerplate',
      theme: ThemeData(
          fontFamily: 'Pretendard',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true),
      darkTheme: ThemeData(
          fontFamily: 'Pretendard',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HOME'),
          elevation: 4,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text('ALL POSTS'),
                  onPressed: () {
                    Get.to(const AllPostsScreen());
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text('SEARCH POST'),
                  onPressed: () {
                    Get.to(const SearchPostScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
