import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/HttpController.dart';
import '../Controller/LikesController.dart';

class HttpPost extends StatelessWidget {
  const HttpPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            const Text("Posts List", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: GetBuilder<HttpController>(builder: (controller) {
                final posts = controller.posts;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return ListTile(
                      title: Text(_getItemTitle(post)),
                      subtitle: Text(_getItemSubtitle(post)),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(_getItemTitle(post)),
                            content: _buildItemDetailDialog(context, post),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Close'),
                              ),

                              Obx(() {
                                final likesController = Get.find<LikesController>();
                                final isLiked = likesController.isLiked('post', post.id.toString());

                                return IconButton(
                                  onPressed: () {
                                    likesController.toggleLike('post', post.id.toString());
                                  },
                                  icon: Icon(
                                      isLiked
                                          ? FluentSystemIcons.ic_fluent_thumb_like_filled
                                          : FluentSystemIcons.ic_fluent_thumb_like_regular
                                  ),
                                  color: isLiked ? Colors.red : null, // Optional: change color when liked
                                );
                              }),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  String _getItemTitle(Post post) => "Title: ${post.title}";

  String _getItemSubtitle(Post post) => "User ID: ${post.userId} | Post ID: ${post.id}";

  Widget _buildItemDetailDialog(BuildContext context, Post post) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(post.body),
          const SizedBox(height: 16),
          Text("User ID: ${post.userId}", style: const TextStyle(fontStyle: FontStyle.italic)),
          Text("Post ID: ${post.id}", style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}