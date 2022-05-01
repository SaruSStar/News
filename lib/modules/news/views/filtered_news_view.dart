import 'package:flutter/material.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/widgets/news_list_tile.dart';

class FilteredNewsView extends StatefulWidget {
  final List<Article?> articals;
  const FilteredNewsView({Key? key, required this.articals}) : super(key: key);

  @override
  _FilteredNewsViewState createState() => _FilteredNewsViewState();
}

class _FilteredNewsViewState extends State<FilteredNewsView> {
  @override
  Widget build(BuildContext context) {
    final news = widget.articals;
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 120),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) {
        final artical = news[index];
        return NewsListTile(artical: artical);
      },
    );
  }
}
