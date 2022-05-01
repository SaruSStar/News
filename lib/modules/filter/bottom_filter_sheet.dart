import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application/constants/filters.dart';
import 'package:news_application/constants/queries.dart';
import 'package:news_application/modules/filter/filter_provider.dart';
import 'package:news_application/widgets/news_filter_chip.dart';
import 'package:provider/provider.dart';

class BottomFilterSheet extends StatelessWidget {
  const BottomFilterSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 28),
              height: 6,
              width: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.headline6,
                ),
                GestureDetector(
                  onTap: () {
                    filterProvider.clearQueries();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              CupertinoIcons.trash,
                              size: 18,
                            ),
                          ),
                          Text(
                            'Reset',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sort By',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                children: Filters.shortBy.entries.map(
                  (entry) {
                    final name = entry.key;
                    final id = entry.value;
                    return SizedBox(
                      // width: 100,
                      child: NewsFilterChip(
                        isSelected:
                            filterProvider.queryParameters[Queries.sortBy] ==
                                id,
                        label: name,
                        onTap: () {
                          filterProvider.copyWith(sortBy: id);
                          filterProvider.fetchAndSetFilterItems();
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Language',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              child: Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.start,
                spacing: 10,
                children: Filters.language.entries.map(
                  (entry) {
                    final name = entry.key;
                    final id = entry.value;
                    return SizedBox(
                      // width: 60,
                      child: NewsFilterChip(
                        isSelected:
                            filterProvider.queryParameters[Queries.language] ==
                                id,
                        label: name,
                        onTap: () {
                          filterProvider.copyWith(language: id);
                          filterProvider.fetchAndSetFilterItems();
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 56,
                margin: const EdgeInsets.only(bottom: 8.0, top: 28),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withAlpha(150),
                    ],
                  ),
                ),
                child: Text(
                  'SAVE',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Theme.of(context).cardColor,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
