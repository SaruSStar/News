import 'package:news_application/constants/queries.dart';

abstract class QueryBuilder {
  final Map<String, dynamic> _queryParameters = <String, dynamic>{
    Queries.q: null,
    Queries.searchIn: null,
    Queries.page: null,
    Queries.pageSize: null,
    Queries.sources: null,
    Queries.from: null,
    Queries.to: null,
    Queries.language: null,
    Queries.sortBy: null,
  };

  Map<String, dynamic> get queryParameters => _queryParameters;

// setting query for the first time when query is empty it will set to null
  void setQueries({
    String? q,
    String? searchIn,
    int? page,
    int? pageSize,
    String? sources,
    String? from,
    String? to,
    String? language,
    String? sortBy,
  }) {
    _queryParameters[Queries.q] = q;
    _queryParameters[Queries.searchIn] = searchIn;
    _queryParameters[Queries.page] = page;
    _queryParameters[Queries.pageSize] = pageSize;
    _queryParameters[Queries.sources] = sources;
    _queryParameters[Queries.from] = from;
    _queryParameters[Queries.to] = to;
    _queryParameters[Queries.language] = language;
    _queryParameters[Queries.sortBy] = sortBy;
  }

//  as usual copywith method existing query will remain if given query is null
  void copyWith({
    String? q,
    String? searchIn,
    int? page,
    int? pageSize,
    String? sources,
    String? from,
    String? to,
    String? language,
    String? sortBy,
  }) {
    _queryParameters[Queries.q] = q ?? _queryParameters[Queries.q];
    _queryParameters[Queries.searchIn] =
        searchIn ?? _queryParameters[Queries.searchIn];
    _queryParameters[Queries.page] = page ?? _queryParameters[Queries.page];
    _queryParameters[Queries.pageSize] =
        pageSize ?? _queryParameters[Queries.pageSize];
    _queryParameters[Queries.sources] =
        sources ?? _queryParameters[Queries.sources];
    _queryParameters[Queries.from] = from ?? _queryParameters[Queries.from];
    _queryParameters[Queries.to] = to ?? _queryParameters[Queries.to];
    _queryParameters[Queries.language] =
        language ?? _queryParameters[Queries.language];
    _queryParameters[Queries.sortBy] =
        sortBy ?? _queryParameters[Queries.sortBy];
  }

  // to remove particular query
  void removeQueryWithKey(String key) {
    _queryParameters.remove(key);
  }

  // to remove all the queries together
  void clearQueries() {
    _queryParameters.forEach((key, value) {
      _queryParameters.update(key, (value) => null);
    });
  }
}
