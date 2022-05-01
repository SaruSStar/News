import 'package:flutter/material.dart';
import 'package:news_application/modules/app/setting_provider.dart';
import 'package:news_application/modules/dashboard/dashboard.dart';
import 'package:news_application/widgets/navigation_bar_icon.dart';
import 'package:provider/provider.dart';

class FloatingNavigationBar extends StatelessWidget {
  const FloatingNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    return Material(
      borderRadius: BorderRadius.circular(43),
      elevation: 8,
      child: SizedBox(
        height: 86,
        child: Column(children: [
          Container(
            height: 6,
            width: 60,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).dividerColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: navigationBarItems.asMap().entries.map((entry) {
                final index = entry.key;
                final dashboard = entry.value;
                return NavigationBarIcon(
                  icon: dashboard.icon,
                  label: dashboard.label,
                  isSelected: settingProvider.navigationBarIndex == index,
                  onTap: () {
                    settingProvider.changeBottomNavigationBarIndex(index);
                  },
                );
              }).toList(),
            ),
          )
        ]),
      ),
    );
  }
}
