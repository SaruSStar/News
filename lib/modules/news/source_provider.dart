import 'package:flutter/foundation.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/services/api/news_api.dart';

class SourceProvider with ChangeNotifier {
  List<Source?> _items = [];
  List<Source?> get items => _items;

  bool _fetchingItems = false;
  bool get fetchingItems => _fetchingItems;

  void changeFetchingItemLoading(bool value) {
    _fetchingItems = value;
    notifyListeners();
  }

  Future<bool> fetchAndSetItems() {
    _fetchingItems = true;
    return NewsApi.getSources().then((sourceRes) {
      if (sourceRes.sources != null) {
        _items = sourceRes.sources ?? [];
        changeFetchingItemLoading(false);
        return true;
      } else {
        changeFetchingItemLoading(false);
        return false;
      }
    }).catchError((error) {
      changeFetchingItemLoading(false);
      return false;
    });
  }
}
