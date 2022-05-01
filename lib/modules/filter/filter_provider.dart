import 'package:flutter/cupertino.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/modules/news/news_provider.dart';
import 'package:news_application/services/api/news_api.dart';
import 'package:provider/provider.dart';

class FilterProvider extends NewsProvider {
  List<Article?> _items = [];
  List<Article?> get filterItems => _items;

  bool _fetchingItems = false;
  bool get fetchingFilterItems => _fetchingItems;

  bool _fetchingPaginationItems = false;
  bool get fetchingFilterPaginationItems => _fetchingPaginationItems;

  int _pageNumber = 1;
  int get filterPageNumber => _pageNumber;

  String? _errorMessage;
  String? get filterErrorMessgage => _errorMessage;

  Source? _selectedSource;
  Source? get selectedSource => _selectedSource;

  void setSourceForFilter(Source? source) {
    _selectedSource = source;
    notifyListeners();
  }

  void changeFetchingFilterItemLoading(bool value) {
    _fetchingItems = value;
    notifyListeners();
  }

  void changeFetchingFilterPaginationItemLoading(bool value) {
    _fetchingPaginationItems = value;
    notifyListeners();
  }

  void keepNewsForAWhile(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    _items = newsProvider.items;
    notifyListeners();
  }

  Future<bool> fetchAndSetFilterItems({bool pagination = false}) {
    copyWith(
      q: newsSearchController.text.isNotEmpty ? newsSearchController.text : 'a',
      page: filterPageNumber,
      sources: selectedSource?.id,
    );

    if (pagination) {
      changeFetchingPaginationItemLoading(true);
    } else {
      _fetchingItems = true;
    }
    return NewsApi.getNews(queries: queryParameters).then((newsRes) {
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

        changeFetchingFilterItemLoading(false);
        changeFetchingFilterPaginationItemLoading(false);
        return true;
      } else {
        changeFetchingFilterItemLoading(false);
        changeFetchingFilterPaginationItemLoading(false);
        return false;
      }
    }).catchError((error) {
      changeFetchingFilterItemLoading(false);
      changeFetchingFilterPaginationItemLoading(false);
      return false;
    }).whenComplete(
      () {
        changeFetchingFilterItemLoading(false);
        changeFetchingFilterPaginationItemLoading(false);
      },
    );
  }
}
