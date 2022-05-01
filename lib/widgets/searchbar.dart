import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  final void Function()? onButtonTap;
  final TextEditingController? controller;
  final Widget? customSuffixIcon;
  final bool autoFocus;
  const Searchbar({
    Key? key,
    this.onButtonTap,
    this.controller,
    this.customSuffixIcon,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  TextEditingController? _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            26,
          ),
        ),
        suffixIcon: widget.customSuffixIcon ??
            IconButton(
              onPressed: widget.onButtonTap,
              icon: const Icon(
                CupertinoIcons.search,
              ),
            ),
      ),
      controller: _textEditingController,
    );
  }
}
