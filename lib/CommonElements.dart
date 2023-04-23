import 'package:flutter/material.dart';

class ValueWrapper {
  var value;

  ValueWrapper(this.value);
}

void showInfoSnackBar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, ValueWrapper isSnackBarActive, String text, Color color) async {
  if (isSnackBarActive.value) {
    return;
  }
  if (scaffoldKey.currentState == null) {
    await Future.delayed(
      Duration(milliseconds: 200),
    );
    if (scaffoldKey.currentState == null) return;
  }
  isSnackBarActive.value = true;
  ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: Text(
            text ?? ('Успешно выполнено'),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: color ?? Colors.grey,
          duration: Duration(seconds: 2),
        ),
      )
      .closed
      .then((SnackBarClosedReason reason) {
    isSnackBarActive.value = false;
  }).timeout(Duration(seconds: 4), onTimeout: () {
    isSnackBarActive.value = false;
  });
}

class GlobalData {
  static int AddServiceValue = 10;
}
