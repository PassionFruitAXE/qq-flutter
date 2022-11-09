import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GlobalMessage {
  static void success(String message, [ToastGravity? gravity]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[400],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void error(String message, [ToastGravity? gravity]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void warning(String message, [ToastGravity? gravity]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange[400],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void info(String message, [ToastGravity? gravity]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[400],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
