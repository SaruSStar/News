import 'package:flutter/foundation.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/utils/database/datebase_helper_favorite.dart';

class FavoriteProvider with ChangeNotifier {
  List<News> _items = [];
  List<News> get items => _items;

  bool _fetchingItems = false;
  bool get fetchingItems => _fetchingItems;

  void changeFetchingItemLoading(bool value) {
    _fetchingItems = value;
    notifyListeners();
  }

  Future<bool> fetchAndSetItems() async {
    try {
      DatabaseHelperFavorite dbHelper = DatabaseHelperFavorite();
      final favItems = await dbHelper.getFavoriteItems() ?? [];
      if (favItems.isNotEmpty) {
        _items = [];
        for (var news in favItems) {
          _items.add(news);
        }
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  void toggleFavorite(News news) {
    if (news.title != null) {
      if (isFavorite(news.title!)) {
        removeFromFavorite(news.id!);
      } else {
        addToFavorite(news).then(
          (value) => fetchAndSetItems(),
        );
      }
    }
  }

  bool isFavorite(String? title) {
    for (var item in items) {
      if (item.title == title) return true;
    }
    return false;
  }

  Future<bool> addToFavorite(News news) async {
    DatabaseHelperFavorite dbHelper = DatabaseHelperFavorite();
    final res = await dbHelper.addToFavourite(news);
    return (res == 1);
  }

  Future<bool> removeFromFavorite(int id) async {
    DatabaseHelperFavorite dbHelper = DatabaseHelperFavorite();
    final res = await dbHelper.removeFromFavorite(id);
    return (res == 1);
  }
}
