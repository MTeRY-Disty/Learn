import 'package:flutter/material.dart';

import '../Controller/HttpController.dart';
import '../core/HttpWidget.dart';

class HttpUser extends HttpWidget<User> {
   HttpUser({super.key})
      : super(
    title: "User List",
    endpoint: "users",
    getData: (controller) => controller.users,
  );

  @override
  Widget buildListItem(BuildContext context, User user) {
    return ListTile(
      title: Text("Name: ${user.name}"),
      subtitle: Text("ID: ${user.id} | Username: ${user.username}"),
    );
  }

  @override
  Widget buildItemDetailDialog(BuildContext context, User user) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      ),
    );
  }

  @override
  String getItemTitle(User user) => "Name: ${user.name}";

  @override
  String getItemSubtitle(User user) => "ID: ${user.id} | Username: ${user.username}";
}