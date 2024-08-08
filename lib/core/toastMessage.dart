import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'dart:ui';

class ToastMessage {
  static toastMessage({
    required String toastMessage,
    bool isSucess = true,
    required String message,
  }) {
    return Get.snackbar(toastMessage, message,
        backgroundColor: isSucess ? Colors.green : Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING);
  }
}
