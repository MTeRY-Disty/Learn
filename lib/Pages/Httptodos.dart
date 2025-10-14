import 'package:c2/Controller/HttpController.dart';
import 'package:c2/core/HttpWidget.dart';
import 'package:flutter/material.dart';

class HttpTodos extends HttpWidget<Todo> {
  HttpTodos({super.key})
      :super(
    title : "ToDos",
    endpoint: "todos",
    getData: (controller) => controller.todos,
  );
  @override
  Widget buildListItem(BuildContext context, Todo todo){
    return ListTile(
      title: Text("Title: ${todo.title}"),
      subtitle: Text("User ID: ${todo.userId} | Post ID: ${todo.id}"),
    );
  }

  @override
  Widget buildItemDetailDialog(BuildContext context, Todo todo){
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
          Text(todo.completed.toString()),
          const SizedBox(height: 16),
          Text("User ID: ${todo.userId}", style: const TextStyle(fontStyle: FontStyle.italic)),
          Text("todo ID: ${todo.id}", style: const TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  @override
  String getItemTitle(Todo todo) => "Title: ${todo.title} ";

  @override
  String getItemSubtitle(Todo todo) => "User ID: ${todo.userId} | Post ID: ${todo.id}";
}