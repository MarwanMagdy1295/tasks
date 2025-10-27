import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasks/src/core/utils/app_colors.dart';

void customToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// void customToastWaiting(String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.TOP,
//     backgroundColor: kOrangeColor,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }
