import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helpers {
  static showDialog() {}

  static showSnackbar({
    String title = '',
    String message = '',
    Color colorText = Colors.white,
    Color backgroundColor = Colors.black54,
  }) {
    Get.back();
    Get.snackbar(
      title,
      message,
      colorText: colorText,
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
