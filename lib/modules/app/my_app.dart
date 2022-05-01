import 'package:flutter/material.dart';
import 'package:news_application/constants/app_constants.dart';
import 'package:news_application/constants/colors.dart';
import 'package:news_application/constants/fonts.dart';
import 'package:news_application/modules/app/root.dart';
import 'package:news_application/modules/app/setting_provider.dart';
import 'package:news_application/modules/favorite/favorite_provider.dart';
import 'package:news_application/modules/filter/filter_provider.dart';
import 'package:news_application/modules/filter/filter_view.dart';
import 'package:news_application/modules/news/news_provider.dart';
import 'package:news_application/modules/news/source_provider.dart';
import 'package:news_application/modules/news/views/single_page_view.dart';
import 'package:news_application/modules/user/user_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => SourceProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MaterialApp(
        title: Constants.appName,
        theme: ThemeData(
            primarySwatch: AppColors.primary,
            fontFamily: Fonts.primary,
            textTheme: const TextTheme(
              headline5: TextStyle(
                fontFamily: Fonts.secondary,
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontFamily: Fonts.secondary,
                fontWeight: FontWeight.bold,
              ),
            )),
        initialRoute: Root.routeName,
        routes: {
          Root.routeName: (context) => const Root(),
          SinglePageView.routeName: (context) => const SinglePageView(),
          FilterView.routeName: (context) => const FilterView(),
        },
      ),
    );
  }
}
