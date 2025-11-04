import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HttpController extends GetxController {
  final dioClient = dio.Dio();
  var users = <User>[].obs;
  var posts = <Post>[].obs;
  var todos = <Todo>[].obs;

  List<User> allUsers = [];
  List<Post> allPosts = [];
  List<Todo> allTodos = [];


  @override
  void onInit() async {
    super.onInit();
    await Future.wait([
      getHttp("users"),
      getHttp("posts"),
      getHttp("todos"),
      ]
    );

  }

  List<T> _getRandomItems<T>(List<T> list, int count) {
    final regularList = list is RxList ? list.toList() : List<T>.from(list);

    if (regularList.length <= count) return List.from(regularList);
    regularList.shuffle(Random());
    return regularList.take(count).toList();
  }

  Future<void> getHttp(String path) async {
    try {
      if (path == 'users') {
        final list = await fetchList<User>(path, User.fromJson);
        users.value = _getRandomItems(list, 5).obs;
        allUsers = list;
      } else if (path == 'posts') {
        final list = await fetchList<Post>(path, Post.fromJson);
        posts.value = _getRandomItems(list, 5);
        allPosts = list;
      }else if (path == 'todos') {
        final list = await fetchList<Todo>(path, Todo.fromJson);
        todos.value = _getRandomItems(list, 5);
        allTodos =list;

      }
      update();
    } catch (e) {
      debugPrint('Request failed: $e');
    }
  }

  Future<List<T>> fetchList<T>(
      String path,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    try {
      final response = await dioClient.get('https://jsonplaceholder.typicode.com/$path');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Request failed: $e');
    }
    return [];
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    address: Address.fromJson(json['address']),
    phone: json['phone'],
    website: json['website'],
    company: Company.fromJson(json['company']),
  );
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: Geo.fromJson(json['geo']),
  );
}

class Geo {
  final String lat;
  final String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json['lat'],
    lng: json['lng'],
  );
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json['name'],
    catchPhrase: json['catchPhrase'],
    bs: json['bs'],
  );
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
  factory Post.fromJson(Map<String, dynamic> json) => Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']
  );

}

class Todo{
  final int userId;
  final int id;
  final String title;
  final bool completed;
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,

  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    userId: json["userId"] ,
    id: json["id"],
    title: json["title"],
    completed: json["completed"]
  );

}