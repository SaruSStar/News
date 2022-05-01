import 'package:flutter/material.dart';
import 'package:news_application/modules/authentication/login_view.dart';
import 'package:news_application/modules/dashboard/dashboard_view.dart';
import 'package:news_application/utils/storage/storage.dart';
import 'package:news_application/widgets/loading_indicator.dart';

class Root extends StatefulWidget {
  static const String routeName = '/';
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Storage.isUserAvailable(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Checking wether user logged in or not to show relevant page
            final isAvailable = (snapshot.data as bool?) ?? false;
            if (isAvailable) {
              return const DashboardView();
            } else {
              return LoginView();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ScreenProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
