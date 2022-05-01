import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_application/constants/images.dart';
import 'package:news_application/modules/news/news_provider.dart';
import 'package:news_application/modules/news/views/single_page_view.dart';
import 'package:news_application/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class LatestNewsView extends StatefulWidget {
  const LatestNewsView({Key? key}) : super(key: key);

  @override
  _LatestNewsViewState createState() => _LatestNewsViewState();
}

class _LatestNewsViewState extends State<LatestNewsView> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    final news = newsProvider.topItems;
    return newsProvider.fetchingTopItems
        ? const Center(
            child: SizedBox(
              height: 100,
              child: ScreenProgressIndicator(),
            ),
          )
        : AspectRatio(
            aspectRatio: 3 / 2,
            child: CarouselSlider(
              items: news.asMap().entries.map(
                (entry) {
                  final artical = entry.value;
                  final index = entry.key;

                  final image = artical?.urlToImage ?? '';
                  final title = artical?.title ?? '';
                  final description = artical?.description ?? '';
                  final author = artical?.author ?? '';
                  return GestureDetector(
                    onTap: () {
                      /// navigating to the SinglePageView with artical argument
                      Navigator.pushNamed(context, SinglePageView.routeName,
                          arguments: artical);
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder: Images.placeHolder,
                                  image: image,
                                  fit: BoxFit.cover,
                                  width: screen.width,
                                  height: double.infinity,
                                  imageErrorBuilder: (_, __, ___) =>
                                      Image.asset(
                                    Images.placeHolder,
                                    height: double.infinity,
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
                              ],
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: const Duration(microseconds: 600),
                          opacity: _pageIndex == index ? 0.3 : 1,
                          child: Container(
                            color: Colors.white70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                author,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Text(
                                  title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color: Theme.of(context).cardColor,
                                      ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                description,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: Theme.of(context).cardColor,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                  aspectRatio: 2 / 1,
                  enlargeCenterPage: true,
                  viewportFraction: 0.86,
                  height: screen.width * 0.6,
                  clipBehavior: Clip.none,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (i, r) {
                    setState(() {
                      _pageIndex = i;
                    });
                  }),
            ),
          );
  }
}
