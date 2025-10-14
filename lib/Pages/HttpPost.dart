import 'package:flutter/material.dart';

import '../Controller/HttpController.dart';
import '../core/HttpWidget.dart';

class HttpPost extends HttpWidget<Post> {
    HttpPost({super.key})
      : super(
    title: "Posts List",
    endpoint: "posts",
    getData: (controller) => controller.posts,
  );

  @override
  Widget buildListItem(BuildContext context, Post post) {
    return ListTile(
      title: Text("Title: ${post.title}"),
      subtitle: Text("User ID: ${post.userId} | Post ID: ${post.id}"),
    );
  }

  @override
  Widget buildItemDetailDialog(BuildContext context, Post post) {
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

  @override
  String getItemTitle(Post post) => "Title: ${post.title}";

  @override
  String getItemSubtitle(Post post) => "User ID: ${post.userId} | Post ID: ${post.id}";
}