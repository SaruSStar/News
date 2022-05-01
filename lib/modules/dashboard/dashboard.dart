import 'package:flutter/cupertino.dart';
import 'package:news_application/modules/favorite/favorite_view.dart';
import 'package:news_application/modules/news/views/home_view.dart';
import 'package:news_application/modules/user/profile_view.dart';


/// Dashboard object to get dashboard view
class Dashboard {
  final IconData icon;
  final String label;
  final Widget view;

  Dashboard({required this.icon, required this.label, required this.view});
}

List<Dashboard> navigationBarItems = [
  Dashboard(
    icon: CupertinoIcons.home,
    label: 'Home',
    view: const HomeView(),
  ),
  Dashboard(
    icon: CupertinoIcons.heart,
    label: 'Favorite',
    view: const FavoriteView(),
  ),
  Dashboard(
    icon: CupertinoIcons.person,
    label: 'Profile',
    view: const ProfileView(),
  ),
];
