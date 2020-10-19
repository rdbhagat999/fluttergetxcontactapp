import 'package:flutter/material.dart';

class SimpleDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  SimpleDialogWidget({
    @required this.title,
    @required this.content,
    @required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions,
      ),
    );
  }
}
