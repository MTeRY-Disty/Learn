import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/HttpController.dart';
import '../Controller/LikesController.dart';

class HttpUser extends StatelessWidget {
  const HttpUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            const Text("User List", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: GetBuilder<HttpController>(builder: (controller) {
                final users = controller.users;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(_getItemTitle(user)),
                      subtitle: Text(_getItemSubtitle(user)),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(_getItemTitle(user)),
                            content: _buildItemDetailDialog(context, user),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Close'),
                              ),

                              Obx(() {
                                final likesController = Get.find<LikesController>();
                                final isLiked = likesController.isLiked('user', user.id.toString()); // Assuming item has id

                                return IconButton(
                                  onPressed: () {
                                    likesController.toggleLike('user', user.id.toString());
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
  String _getItemTitle(User user) => "Name: ${user.name}";

  String _getItemSubtitle(User user) => "ID: ${user.id} | Username: ${user.username}";

  Widget _buildItemDetailDialog(BuildContext context, User user) {
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
}