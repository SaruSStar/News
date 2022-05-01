import 'package:flutter/material.dart';
import 'package:news_application/modules/filter/bottom_filter_sheet.dart';
import 'package:news_application/modules/filter/filter_provider.dart';
import 'package:news_application/modules/news/source_provider.dart';
import 'package:news_application/widgets/news_filter_chip.dart';
import 'package:provider/provider.dart';

class FilterChipsListView extends StatelessWidget {
  final bool showFilterButton;
  const FilterChipsListView({
    Key? key,
    this.showFilterButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourceProvider = Provider.of<SourceProvider>(context);
    final filterProvider = Provider.of<FilterProvider>(context);
    final sources = sourceProvider.items;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Visibility(
            visible: showFilterButton,
            child: NewsFilterChip(
                label: 'Filter',
                isSelected: true,
                showIcon: true,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const BottomFilterSheet(),
                  );
                }),
          ),
          ...sources.map((source) {
            return NewsFilterChip(
              label: source?.name ?? '-',
              isSelected: filterProvider.selectedSource?.id == source?.id,
              onTap: () {
                /// Setting source object to filter news
                filterProvider.setSourceForFilter(source);
                /// Making api cals as per the new queries set
                filterProvider.fetchAndSetFilterItems();
              },
            );
          }),
        ],
      ),
    );
  }
}
