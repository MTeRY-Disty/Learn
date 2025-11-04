import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/HttpController.dart';
import '../Controller/LikesController.dart';
import '../Controller/SortController.dart';

class HttpTodos extends StatelessWidget {
  const HttpTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text("ToDos".tr, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),

            _buildSortControls(),
            const SizedBox(height: 16),


            Expanded(
              child: GetBuilder<HttpController>(builder: (controller) {
                final sortController = Get.find<SortController>();
                final todos = sortController.applySort(controller.todos);

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
                                child: Text('Close'.tr),
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
  String _getItemTitle(Todo todo) => "${"Title".tr}: ${todo.title}";

  String _getItemSubtitle(Todo todo) => "${"User ID".tr}: ${todo.userId} | ${"Todo ID".tr}: ${todo.id}";

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
          Text("${"Completed".tr}: ${todo.completed ? "Yes".tr : "No".tr}"),
          const SizedBox(height: 16),
          Text("${"User ID".tr}: ${todo.userId}", style: const TextStyle(fontStyle: FontStyle.italic)),
          Text("${"Todo ID".tr}: ${todo.id}", style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildSortControls() {
    return GetBuilder<SortController>(
      builder: (sortController) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Sort by ID
            ElevatedButton(
              onPressed: () =>{
                sortController.sortBy(SortField.id),
              },
              style: _getSortButtonStyle(SortField.id, sortController),
              child: Row(
                children: [
                  Text('Sort by ID'.tr),
                  if (sortController.currentSortField.value == SortField.id)
                    Icon(
                      sortController.isAscending.value
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }


  //for button styling
  ButtonStyle _getSortButtonStyle(SortField field, SortController controller) {
    final isActive = controller.currentSortField.value == field;
    return ElevatedButton.styleFrom(
      backgroundColor: isActive ? Colors.blue : Colors.grey,
      foregroundColor: Colors.white,
    );
  }


}