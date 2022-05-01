import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_application/constants/images.dart';
import 'package:news_application/models/models.dart';
import 'package:news_application/modules/news/views/single_page_view.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({
    Key? key,
    required this.artical,
  }) : super(key: key);

  final Article? artical;

  @override
  Widget build(BuildContext context) {
    final image = artical?.urlToImage ?? '';
    final author = artical?.author ?? '';
    final title = artical?.title ?? '';
    final date =
        DateFormat.yMMMMEEEEd().format(artical?.publishedAt ?? DateTime.now());
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SinglePageView.routeName,
            arguments: artical);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 160,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(children: [
            FadeInImage.assetNetwork(
              image: image,
              placeholder: Images.placeHolder,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              imageErrorBuilder: (_, __, ___) => Image.asset(
                Images.placeHolder,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black54,
                    Colors.black12,
                    Colors.white10,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              color: Colors.white38,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          author,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: Theme.of(context).cardColor,
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
