import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message {
  static void flutterToast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        backgroundColor: Color.fromARGB(255, 248, 38, 23),
        timeInSecForIosWeb: 3);
  }
}
