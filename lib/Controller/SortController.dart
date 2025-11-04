import 'package:get/get.dart';

import 'HttpController.dart';

class SortController extends GetxController {
  var currentSortField = SortField.none.obs;
  var isAscending = true.obs;

  void sortBy(SortField field) {
    if (currentSortField.value == field) {
      isAscending.toggle();
    } else {
      currentSortField.value = field;
      isAscending.value = true;
    }
    update();
    Get.find<HttpController>().update();
  }

List<T> applySort<T>(List<T> items) {
  if (currentSortField.value == SortField.none) return items;

  final sorted = List<T>.from(items);

  sorted.sort((a, b) {
    final aValue = _getSortValue(a, currentSortField.value);
    final bValue = _getSortValue(b, currentSortField.value);

    final comparison = aValue.compareTo(bValue);
    return isAscending.value ? comparison : -comparison;
  });

  return sorted;
}

Comparable _getSortValue<T>(T item, SortField field) {
  switch (field) {
    case SortField.id:
      return _getId(item);
    case SortField.userId:
      return _getUserId(item);
    case SortField.name:
      return _getName(item)?.toLowerCase() ?? '';
    case SortField.username:
      return _getUsername(item)?.toLowerCase() ?? '';
    case SortField.title:
      return _getTitle(item)?.toLowerCase() ?? '';
    default:
      return 0;
  }
}

int _getId<T>(T item) {
  if (item is User) return item.id;
  if (item is Post) return item.id;
  if (item is Todo) return item.id;
  return 0;
}

int _getUserId<T>(T item) {
  if (item is User) return item.id;
  if (item is Post) return item.userId;
  if (item is Todo) return item.userId;
  return 0;
}

String? _getName<T>(T item) {
  if (item is User) return item.name;
  return null;
}

String? _getUsername<T>(T item) {
  if (item is User) return item.username;
  return null;
}

String? _getTitle<T>(T item) {
  if (item is Post) return item.title;
  if (item is Todo) return item.title;
  return null;
}
}

//  options for sorting for all pages
enum SortField {
  none,
  id,
  userId,
  name,
  username,
  title
}