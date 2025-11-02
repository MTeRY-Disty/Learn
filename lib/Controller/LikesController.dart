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

  String _getLikeKey(String type, String id) {
    return '$type:$id';
  }

  bool isLiked(String type, String id) {
    final key = _getLikeKey(type, id);
    return _likedItems.contains(key);
  }

  void toggleLike(String type, String id) {
    final key = _getLikeKey(type, id);
    if (_likedItems.contains(key)) {
      _likedItems.remove(key);
    } else {
      _likedItems.add(key);
    }
    _storage.write('likedItems', _likedItems.toList());
  }
}