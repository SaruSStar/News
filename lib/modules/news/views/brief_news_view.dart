import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:news_application/constants/images.dart';
import 'package:news_application/models/models.dart';

class BriefNewsView extends StatefulWidget {
  final String title;
  final List<Article?> news;
  const BriefNewsView({Key? key, required this.title, required this.news})
      : super(key: key);

  @override
  _BriefNewsViewState createState() => _BriefNewsViewState();
}

class _BriefNewsViewState extends State<BriefNewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Theme.of(context).textTheme.subtitle1?.color,
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle1?.color,
          ),
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          itemCount: widget.news.length,
          itemBuilder: ((context, index) {
            final artical = widget.news[index];
            final image = artical?.urlToImage;
            final title = artical?.title ?? '';
            final content = artical?.content ?? '';
            final author = artical?.author ?? '';
            final date = DateFormat.yMMMMEEEEd()
                .format(artical?.publishedAt ?? DateTime.now());
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: image == null
                        ? const SizedBox.shrink()
                        : AspectRatio(
                            aspectRatio: 20 / 9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: FadeInImage.assetNetwork(
                                image: image,
                                placeholder: Images.placeHolder,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (_, __, ___) => Image.asset(
                                  Images.placeHolder,
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6?.copyWith(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  HtmlWidget(
                    content,
                    textStyle:
                        Theme.of(context).textTheme.subtitle1?.copyWith(),
                  ),
                  Text(
                    author,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]);
          })),
    );
  }
}
