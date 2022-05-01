import 'package:flutter/Material.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/modules/news/views/filtered_news_view.dart';
import 'package:news_application/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

import 'favorite_provider.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  bool init = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      final favoriteProvider =
          Provider.of<FavoriteProvider>(context, listen: false);
      favoriteProvider.fetchAndSetItems();
      setState(() {
        init = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final news = favoriteProvider.items;
    if (favoriteProvider.fetchingItems) {
      return const Scaffold(
        body: Center(
          child: SizedBox(
            height: 100,
            child: ScreenProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      body: news.isEmpty
          ? Center(
              child: Text(
                'No favoutire items added yet!',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: FilteredNewsView(
                  articals: news
                      .map(
                        (article) => Article(
                          author: article.author,
                          content: article.content,
                          description: article.description,
                          publishedAt: article.publishedAt == null
                              ? null
                              : DateTime.parse(article.publishedAt!),
                          source: Source(name: article.source),
                          title: article.title,
                          urlToImage: article.urlToImage,
                        ),
                      )
                      .toList()),
            ),
    );
  }
}
