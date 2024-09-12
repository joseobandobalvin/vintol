import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static errorSnackBar({required title, message = ""}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(milliseconds: 1),
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.black87,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 30),
      margin: const EdgeInsets.all(20),
      snackStyle: SnackStyle.GROUNDED,
      //barBlur: 100.0,
    );
  }

  static snackBarFlutter(BuildContext context, {String? message}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      dismissDirection: DismissDirection.horizontal,
      content: Text(
        maxLines: 2,
        message!,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
      ),
      action: SnackBarAction(
        label: 'Deshacer',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
