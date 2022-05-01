import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts {
  static Future showDialogOK(BuildContext context,
      {required String title, required String message}) {
    bool isIOs = Theme.of(context).platform == TargetPlatform.iOS;
    TextButton textButton = TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("OK"),
    );
    return showDialog(
        context: context,
        builder: (context) {
          if (isIOs) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [textButton],
            );
          } else {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [textButton],
            );
          }
        });
  }
}
