import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  error(String message) {
          Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        webShowClose: true,
        gravity:
        ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        webBgColor: "#db3a1a", // red, which looks kinda ok
        textColor: Colors.white,
        fontSize: 16.0,
      );
  }

  // TODO: other toasts as needed
}