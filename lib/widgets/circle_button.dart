import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final void Function()? onTap;
  const CircleButton({
    Key? key,
    required this.icon,
    this.iconColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withAlpha(150),
          ],
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor ?? Theme.of(context).cardColor,
        ),
        onPressed: onTap,
      ),
    );
  }
}
