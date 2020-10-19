import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TypewriterWidget extends StatelessWidget {
  final double width;
  final List<String> textList;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final AlignmentDirectional alignment;
  final Function onTap;
  final bool repeatForever;
  final Duration speed;

  TypewriterWidget({
    this.width = 250.0,
    @required this.textList,
    this.textStyle,
    this.speed,
    this.textAlign = TextAlign.start,
    this.onTap,
    this.alignment = AlignmentDirectional.topStart,
    this.repeatForever = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TypewriterAnimatedTextKit(
        onTap: onTap,
        text: textList,
        textStyle: textStyle,
        textAlign: textAlign,
        alignment: alignment, // or Alignment.topLeft
        repeatForever: repeatForever,
        speed: speed ?? Duration(milliseconds: 300),
      ),
    );
  }
}
