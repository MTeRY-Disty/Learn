import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LikesController extends GetxController {
  final _storage = GetStorage();
  final _likedItems = <String>{}.obs;

  Set<String> get likedItems => _likedItems;

  @override
  void onInit() {
    super.onInit();
    final savedLikes = _storage.read<List>('likedItems') ?? [];
    _likedItems.addAll(savedLikes.cast<String>());
  }

  bool isLiked(String itemId) {
    return _likedItems.contains(itemId);
  }

  void toggleLike(String itemId) {
    if (_likedItems.contains(itemId)) {
      _likedItems.remove(itemId);
    } else {
      _likedItems.add(itemId);
    }
    _storage.write('likedItems', _likedItems.toList());
  }
}