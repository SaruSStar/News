import 'package:flutter/material.dart';

class NavigationBarIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final void Function()? onTap;
  const NavigationBarIcon({
    Key? key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  _NavigationBarIconState createState() => _NavigationBarIconState();
}

class _NavigationBarIconState extends State<NavigationBarIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.white10,
        width: 56,
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
            Text(
              widget.label,
              style: TextStyle(
                color:
                    widget.isSelected ? null : Theme.of(context).disabledColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
