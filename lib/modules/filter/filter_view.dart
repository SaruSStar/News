import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_application/modules/filter/filter_provider.dart';
import 'package:news_application/modules/news/views/filter_chips_list_view.dart';
import 'package:news_application/modules/news/views/filtered_news_view.dart';
import 'package:news_application/widgets/loading_indicator.dart';
import 'package:news_application/widgets/searchbar.dart';
import 'package:provider/provider.dart';

class FilterView extends StatefulWidget {
  static const String routeName = '/filter';
  const FilterView({Key? key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels ==
          controller.position.maxScrollExtent - 300) {
        final filterProvider =
            Provider.of<FilterProvider>(context, listen: false);
        if (filterProvider.fetchingFilterItems == false &&
            filterProvider.fetchingFilterPaginationItems == false) {
          filterProvider.fetchAndSetFilterItems(pagination: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    if (filterProvider.fetchingFilterItems) {
      return const Scaffold(
        body: Center(
          child: SizedBox(
            height: 100,
            child: ScreenProgressIndicator(),
          ),
        ),
      );
    } else if (filterProvider.filterErrorMessgage != null) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              filterProvider.filterErrorMessgage.toString(),
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: controller,
            child: Column(children: [
              buildSearchBarWithButton(),
              buildFilterChips(),
              buildfilterNewsView(),
              Visibility(
                visible: filterProvider.fetchingFilterPaginationItems,
                child: const SizedBox(
                  height: 6,
                  child: LinearProgressIndicator(),
                ),
              )
            ]),
          ),
        ),
      );
    }
  }

  Widget buildfilterNewsView() {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        child: FilteredNewsView(articals: filterProvider.filterItems),
      ),
    );
  }

  Widget buildFilterChips() {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: FilterChipsListView(
          showFilterButton: true,
        ),
      ),
    );
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
              autoFocus: true,
              controller: filterProvider.newsSearchController,
              onButtonTap: () {
                filterProvider.fetchAndSetFilterItems();
              },
              customSuffixIcon: IconButton(
                icon: const Icon(CupertinoIcons.clear),
                onPressed: () {
                  filterProvider.newsSearchController.text = "";
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
