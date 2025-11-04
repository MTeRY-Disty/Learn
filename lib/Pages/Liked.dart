import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/LikesController.dart';
import '../Controller/HttpController.dart';
import '../Pages/HttpUser.dart';
import '../Pages/HttpPost.dart';
import '../Pages/HttpTodos.dart';

class LikedItemsPage extends StatelessWidget {
  const LikedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
             Text("Liked Items".tr, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: Obx ((){
                final likesController = Get.find<LikesController>();
                final httpController = Get.find<HttpController>();
                final likedIds = likesController.likedItems.toList();

                if (likedIds.isEmpty) {
                  return  Center(
                    child: Text(
                      "No liked items yet".tr,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                // Get all items from different controllers
                final allItems = <dynamic>[
                  ...httpController.allUsers,
                  ...httpController.allPosts,
                  ...httpController.allTodos,
                ];

                // Filter only liked items
                final likedItems = allItems.where((item) {
                  String type;
                  if (item is User) {type = 'user';}
                  else if (item is Post) {type = 'post';}
                  else if (item is Todo){ type = 'todo';}
                  else {return false;}

                  return likedIds.contains('$type:${item.id.toString()}');
                }).toList();

                return ListView.builder(
                  itemCount: likedItems.length,
                  itemBuilder: (context, index) {
                    final item = likedItems[index];
                    return ListTile(
                      title: Text(_getItemTitle(item)),
                      subtitle: Text(_getItemSubtitle(item)),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(_getItemTitle(item)),
                            content: _buildItemDetailDialog(context, item),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Close'),
                              ),
                              Obx(() {
                                String type;
                                if (item is User) {type = 'user';}
                                else if (item is Post) {type = 'post';}
                                else if (item is Todo) {type = 'todo';}
                                else {type = 'unknown';}

                                final isLiked = likesController.isLiked(type, item.id.toString());
                                return IconButton(
                                  onPressed: () {
                                    likesController.toggleLike(type, item.id.toString());
                                  },
                                  icon: Icon(
                                      isLiked
                                          ? FluentSystemIcons.ic_fluent_thumb_like_filled
                                          : FluentSystemIcons.ic_fluent_thumb_like_regular
                                  ),
                                  color: isLiked ? Colors.red : null,
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
  String _getItemTitle(dynamic item) {
    if (item is User) {
      return "User: ${item.name}";
    } else if (item is Post) {
      return "Post: ${item.title}";
    } else if (item is Todo) {
      return "Todo: ${item.title}";
    }
    return "Unknown Item";
  }

  String _getItemSubtitle(dynamic item) {
    if (item is User) {
      return "Email: ${item.email}";
    } else if (item is Post) {
      return "User ID: ${item.userId} | Post ID: ${item.id}";
    } else if (item is Todo) {
      return "User ID: ${item.userId} | Completed: ${item.completed}";
    }
    return "Unknown Type";
  }

  Widget _buildItemDetailDialog(BuildContext context, dynamic item) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item is User) ..._buildUserContent(item),
          if (item is Post) ..._buildPostContent(item),
          if (item is Todo) ..._buildTodoContent(item),
        ],
      ),
    );
  }

  List<Widget> _buildUserContent(User user) {
    return [
      Text("Email: ${user.email}"),
      const SizedBox(height: 16),
      const Text("Address:", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Street: ${user.address.street}"),
      Text("Suite: ${user.address.suite}"),
      Text("City: ${user.address.city}"),
      Text("Zipcode: ${user.address.zipcode}"),
      Text("Geo: lat: ${user.address.geo.lat} | lng: ${user.address.geo.lng}"),
      const SizedBox(height: 16),
      Text("Phone: ${user.phone}"),
      const SizedBox(height: 16),
      Text("Website: ${user.website}"),
      const SizedBox(height: 16),
      const Text("Company:", style: TextStyle(fontWeight: FontWeight.bold)),
      Text("Name: ${user.company.name}"),
      Text("Catch Phrase: ${user.company.catchPhrase}"),
      Text("BS: ${user.company.bs}"),
    ];
  }

  List<Widget> _buildPostContent(Post post) {
    return [
      Text(
        post.title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Text(post.body),
      const SizedBox(height: 16),
      Text("User ID: ${post.userId}", style: const TextStyle(fontStyle: FontStyle.italic)),
      Text("Post ID: ${post.id}", style: const TextStyle(fontStyle: FontStyle.italic)),
    ];
  }

  List<Widget> _buildTodoContent(Todo todo) {
    return [
      Text(
        todo.title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Text("Completed: ${todo.completed ? 'Yes' : 'No'}"),
      const SizedBox(height: 16),
      Text("User ID: ${todo.userId}", style: const TextStyle(fontStyle: FontStyle.italic)),
      Text("Todo ID: ${todo.id}", style: const TextStyle(fontStyle: FontStyle.italic)),
    ];
  }
}