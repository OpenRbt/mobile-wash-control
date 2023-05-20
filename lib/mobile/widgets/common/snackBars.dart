import 'package:flutter/material.dart';

class SnackBars {
  static SnackBar getInfoSnackBar({required String message}) {
    return SnackBar(content: Text(message));
  }

  static SnackBar getSuccessSnackBar({required String message}) {
    return SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.green,
      content: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          Flexible(
            child: Text(
              message,
            ),
          ),
        ],
      ),
    );
  }

  static SnackBar getWarningSnackBar({required String message}) {
    return SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.orange,
      content: Row(
        children: [
          Icon(
            Icons.warning_amber_outlined,
            color: Colors.white,
          ),
          Flexible(
            child: Text(
              message,
            ),
          ),
        ],
      ),
    );
  }

  static SnackBar getErrorSnackBar({required String message}) {
    return SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          Flexible(
            child: Text(
              message,
            ),
          ),
        ],
      ),
    );
  }
}
