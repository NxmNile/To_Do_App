import 'package:flutter/material.dart';

void destroy(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}
void alert({
  required BuildContext context,
  String title = "{title}",
  String message = "{content}",
  String keyAction = "Okay",
  Function? callback,
}) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              // Close the success alert only
              if (Navigator.of(dialogContext).canPop()) {
                Navigator.of(dialogContext).pop();
              }
              // Ensure no extra pop() calls
              if (callback != null) {
                Future.delayed(Duration(milliseconds: 200), () {
                  callback();
                });
              }
            },
            child: Text(keyAction),
          ),
        ],
      );
    },
  );
}


