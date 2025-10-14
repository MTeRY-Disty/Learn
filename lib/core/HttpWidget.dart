import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/HttpController.dart';

abstract class HttpWidget<T> extends StatelessWidget {
  final String title;
  final String endpoint;
  final List<T> Function(HttpController controller) getData;

    HttpWidget({
    super.key,
    required this.title,
    required this.endpoint,
    required this.getData,
  });

  // Abstract methods that subclasses must implement
  Widget buildListItem(BuildContext context, T item);
  Widget buildItemDetailDialog(BuildContext context, T item);
  String getItemTitle(T item);
  String getItemSubtitle(T item);

  @override
  Widget build(BuildContext context) {
    print("here");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: GetBuilder<HttpController>(builder: (controller) {
                final items = getData(controller); //how do u know if the data is ready?
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(getItemTitle(item)),
                      subtitle: Text(getItemSubtitle(item)),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(getItemTitle(item)),
                            content: buildItemDetailDialog(context, item),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Close'),
                              ),
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
}