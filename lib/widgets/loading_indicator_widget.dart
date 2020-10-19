import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final Color backgroundColor;
  final String semanticsLabel;
  final String semanticsValue;

  LoadingIndicatorWidget({
    this.backgroundColor = Colors.white60,
    this.semanticsLabel = 'Loading',
    this.semanticsValue = 'please wait..',
  });

  Widget _buildLoadingWidget(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: backgroundColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: _buildLoadingWidget(context),
    ));
  }

  static void showLoadingIndicator({
    bool barrierDismissible = false,
    Color barrierColor = Colors.black54,
  }) {
    Get.dialog(
      LoadingIndicatorWidget(),
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
    );
  }
}
