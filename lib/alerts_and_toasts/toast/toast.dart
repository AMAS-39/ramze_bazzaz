import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool _isOpen = false;
Future<void> showToast(String title) async {
  if (_isOpen == true) {
    await Fluttertoast.cancel();
    _isOpen = false;
  }

  _isOpen = true;
  await Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Helper.i.context.primaryColor,
      textColor: Colors.white,
      fontSize: 16.sp);
}
