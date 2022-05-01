import 'package:flutter/cupertino.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/modules/news/query_builder.dart';
import 'package:news_application/services/api/news_api.dart';

class NewsProvider with ChangeNotifier, QueryBuilder {
  List<Article?> _items = [];
  List<Article?> get items => _items;

  List<Article?> _topItems = [];
  List<Article?> get topItems => _topItems;

  bool _fetchingItems = false;
  bool get fetchingItems => _fetchingItems;

  bool _fetchingPaginationItems = false;
  bool get fetchingPaginationItems => _fetchingPaginationItems;

  bool _fetchingTopItems = false;
  bool get fetchingTopItems => _fetchingTopItems;

  TextEditingController newsSearchController = TextEditingController();

  int _pageNumber = 1;
  int get pageNumber => _pageNumber;

  int _topNewsPageNumber = 1;

  String? _errorMessage;
  String? get errorMessgage => _errorMessage;

  // retry button for demontrate purpose to get back to home pabe or make request again
  void retry() {
    if (_items.isNotEmpty) {
      _errorMessage = null;
      notifyListeners();
    } else {
      _pageNumber = 1;
      fetchAndSetItems();
    }
  }

  void changeFetchingItemLoading(bool value) {
    _fetchingItems = value;
    notifyListeners();
  }

  void changeFetchingPaginationItemLoading(bool value) {
    _fetchingPaginationItems = value;
    notifyListeners();
  }

  void changeFetchingTopItemLoading(bool value) {
    _fetchingTopItems = value;
    notifyListeners();
  }

  Future<bool> fetchAndSetItems({bool pagination = false}) {
    // q is one of the required params so let me make a as default to get results
    copyWith(q: 'a', page: pageNumber);

    if (pagination) {
      changeFetchingPaginationItemLoading(true);
    } else {
      _fetchingItems = true;
    }
    return NewsApi.getNews(queries: queryParameters).then((newsRes) {
      // always getting error message to show it to the user
      _errorMessage = newsRes.message;
      if (newsRes.articles != null) {
        if (pagination == false) {
          _items = [];
        }
        final items = newsRes.articles ?? [];
        for (var element in items) {
          _items.add(element);
        }
        _pageNumber++;

        changeFetchingItemLoading(false);
        changeFetchingPaginationItemLoading(false);
        return true;
      } else {
        changeFetchingItemLoading(false);
        changeFetchingPaginationItemLoading(false);
        return false;
      }
    }).catchError((error) {
      changeFetchingItemLoading(false);
      changeFetchingPaginationItemLoading(false);
      return false;
    }).whenComplete(
      () {
        changeFetchingItemLoading(false);
        changeFetchingPaginationItemLoading(false);
      },
    );
  }

  // this is the latest news fetch
  Future<bool> fetchAndSetTopItems({bool pagination = false}) {
    setQueries(q: 'a', page: _topNewsPageNumber);

    _fetchingItems = true;
    // notifyListeners();
    return NewsApi.getTopNews(queries: queryParameters).then((newsRes) {
      _errorMessage = newsRes.message;
      if (newsRes.articles != null) {
        if (pagination == false) {
          _topItems = [];
        }
        _topNewsPageNumber++;
        _topItems = newsRes.articles ?? [];
        changeFetchingItemLoading(false);
        return true;
      } else {
        changeFetchingItemLoading(false);
        return false;
      }
    }).catchError((error) {
      changeFetchingItemLoading(false);
      return false;
    }).whenComplete(
      () => changeFetchingItemLoading(false),
    );
  }
}
