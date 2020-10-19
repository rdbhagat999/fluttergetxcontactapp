import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizeTextWidget extends StatelessWidget {
  final double width;
  final double minFontSize;
  final String text;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final TextStyle style;
  final int maxLines;

  AutoSizeTextWidget({
    this.text = 'Demo text',
    this.style,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.minFontSize = 14.0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AutoSizeText(
        '$text',
        style: style,
        overflow: overflow,
        minFontSize: minFontSize,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
