import 'package:flutter/material.dart';

class NewsFilterChip extends StatelessWidget {
  const NewsFilterChip({
    Key? key,
    this.isSelected = false,
    this.showIcon = false,
    required this.label,
    this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final bool showIcon;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withAlpha(150),
                    ],
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showIcon)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.sort_outlined,
                      size: 18,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: isSelected ? Theme.of(context).cardColor : null,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
