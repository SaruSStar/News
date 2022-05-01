import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application/constants/colors.dart';
import 'package:news_application/modules/filter/filter_provider.dart';
import 'package:news_application/modules/filter/filter_view.dart';
import 'package:news_application/modules/news/news_provider.dart';
import 'package:news_application/modules/news/views/brief_news_view.dart';
import 'package:news_application/modules/news/views/filter_chips_list_view.dart';
import 'package:news_application/modules/news/views/filtered_news_view.dart';
import 'package:news_application/modules/news/views/latest_news_view.dart';
import 'package:news_application/widgets/circle_button.dart';
import 'package:news_application/widgets/loading_indicator.dart';
import 'package:news_application/widgets/searchbar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController controller = ScrollController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        print('ready to fetch');
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        print(newsProvider.fetchingItems == false);
        print(newsProvider.fetchingPaginationItems == false);
        if (newsProvider.fetchingItems == false &&
            newsProvider.fetchingPaginationItems == false) {
          newsProvider.fetchAndSetItems(pagination: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    if (newsProvider.fetchingItems) {
      return const Center(
        child: SizedBox(
          height: 100,
          child: ScreenProgressIndicator(),
        ),
      );
    } else if (newsProvider.errorMessgage != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            newsProvider.errorMessgage.toString(),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: const Text('Retry/ Back to Home'),
              onPressed: () {
                /// Retry function show back [HomeView] if news is not empty
                /// If it is empty it will make a get request
                newsProvider.retry();
              },
            ),
          )
        ],
      );
    } else {
      return SingleChildScrollView(
        controller: controller,
        child: Column(children: [
          buildSearchBarWithButton(),
          buildLatestNews(),
          buildFilterChips(),
          buildfilterNewsView(),
          Visibility(
            visible: newsProvider.fetchingPaginationItems,
            child: const SizedBox(
              height: 6,
              child: LinearProgressIndicator(),
            ),
          )
        ]),
      );
    }
  }

  Widget buildfilterNewsView() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        child: FilteredNewsView(articals: newsProvider.items),
      ),
    );
  }

  Widget buildFilterChips() {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: SizedBox(
        height: 56,
        child: FilterChipsListView(),
      ),
    );
  }

  Column buildLatestNews() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest News',
              style: Theme.of(context).textTheme.headline5,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 20,
                    ),
                primary: AppColors.secoundary,
              ),
              onPressed: () {
                /// this function navigate to [BriefNewsView]
                /// One of the view from the Figma UI
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BriefNewsView(
                      title: 'Latest News',
                      news: newsProvider.topItems,
                    ),
                  ),
                );
              },
              label: const Icon(Icons.arrow_forward),
              icon: const Text('See All'),
            )
          ],
        ),
      ),
      Transform.translate(
        offset: const Offset(-18, 0),
        child: const LatestNewsView(),
      )
    ]);
  }

  Padding buildSearchBarWithButton() {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 30,
      ),
      child: Row(
        children: [
          Expanded(
            child: Searchbar(
              controller: filterProvider.newsSearchController,
              onButtonTap: () {
                if (filterProvider.newsSearchController.text.isNotEmpty) {
                  /// Simply fetching filter items using [FilterProvider] query text will
                  /// be taken from the [TextEditingController] from [NewsProvider]
                  filterProvider.fetchAndSetFilterItems();
                  /// Navigating instantly loader will be executed in [FilterView]
                  Navigator.pushNamed(context, FilterView.routeName);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: CircleButton(
              icon: CupertinoIcons.bell,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
