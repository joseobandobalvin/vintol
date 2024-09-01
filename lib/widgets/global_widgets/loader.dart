import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static errorSnackBar({required title, message = ""}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.black87,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 30),
      margin: const EdgeInsets.all(20),
      //barBlur: 100.0,
    );
  }
}
