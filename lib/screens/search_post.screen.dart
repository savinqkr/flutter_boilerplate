import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../models/post.model.dart';
import '../services/post.service.dart';
import '../widgets/textfield_box.widget.dart';

class SearchPostScreen extends HookWidget {
  const SearchPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = useTextEditingController();

    var postId = useState<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SEARCH POST'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFieldBox(
                  width: 280,
                  height: 40,
                  controller: searchController,
                  hintText: '1~100 까지의 정수를 입력해주세요.',
                ),
                FilledButton(
                  child: const Icon(Icons.search),
                  onPressed: () {
                    postId.value = int.parse(searchController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: FutureBuilder<PostModel?>(
                future: PostService().getPostById(postId.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('검색된 POST 가 없습니다.');
                  } else {
                    final post = snapshot.data;

                    return post == null
                        ? const Text('검색된 POST 가 없습니다.')
                        : Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 30),
                              child: Column(
                                children: [
                                  Text(
                                    '${post.postId}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    post.postTitle,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  Text(post.postBody),
                                ],
                              ),
                            ),
                          );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
