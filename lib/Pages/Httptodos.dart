import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/HttpController.dart';
import '../Controller/LikesController.dart';

class HttpTodos extends StatelessWidget {
  const HttpTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            const Text("ToDos", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: GetBuilder<HttpController>(builder: (controller) {
                final todos = controller.todos;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(_getItemTitle(todo)),
                      subtitle: Text(_getItemSubtitle(todo)),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(_getItemTitle(todo)),
                            content: _buildItemDetailDialog(context, todo),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Close'),
                              ),
                              Obx(() {
                                final likesController = Get.find<LikesController>();
                                final isLiked = likesController.isLiked('todo', todo.id.toString());

                                return IconButton(
                                  onPressed: () {
                                    likesController.toggleLike('todo', todo.id.toString());
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
  String _getItemTitle(Todo todo) => "Title: ${todo.title}";

  String _getItemSubtitle(Todo todo) => "User ID: ${todo.userId} | Todo ID: ${todo.id}";

  Widget _buildItemDetailDialog(BuildContext context, Todo todo) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text("Completed: ${todo.completed ? 'Yes' : 'No'}"),
          const SizedBox(height: 16),
          Text("User ID: ${todo.userId}", style: const TextStyle(fontStyle: FontStyle.italic)),
          Text("Todo ID: ${todo.id}", style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}