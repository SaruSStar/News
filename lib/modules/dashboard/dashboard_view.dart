import 'package:flutter/material.dart';
import 'package:news_application/modules/app/setting_provider.dart';
import 'package:news_application/modules/dashboard/dashboard.dart';
import 'package:news_application/modules/news/news_provider.dart';
import 'package:news_application/modules/news/source_provider.dart';
import 'package:news_application/widgets/floating_navigation_bar.dart';
import 'package:news_application/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      final sourceProvider =
          Provider.of<SourceProvider>(context, listen: false);
      setState(() => loading = true);
      Future.wait([
        newsProvider.fetchAndSetItems(),
        newsProvider.fetchAndSetTopItems(),
        sourceProvider.fetchAndSetItems(),
      ]).whenComplete(() {
        setState(() => loading = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final settingProvider = Provider.of<SettingProvider>(context);
    if (newsProvider.fetchingItems) {
      return const Scaffold(
        // loading indiacator until fetch relavent data
        body: Center(
          child: SizedBox(
            height: 100,
            child: ScreenProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Stack(children: [
            IndexedStack(
              index: settingProvider.navigationBarIndex,
              children: [
                ...navigationBarItems
                    .map<Widget>((navBarItem) => navBarItem.view)
                    .toList(),
              ],
            ),
            Visibility(

                /// to hide [FloatingNavigationBar] when keyboard opens
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: buildFloatingNavigationBar()),
          ]),
        ),
      );
    }
  }

  Widget buildFloatingNavigationBar() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: FloatingNavigationBar(),
      ),
    );
  }
}
