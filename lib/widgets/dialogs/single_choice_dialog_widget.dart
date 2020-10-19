import 'package:flutter/material.dart';

class SingleChoiceDialogWidget extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final dynamic selectedItem;
  final Function onChanged;
  SingleChoiceDialogWidget({
    @required this.title,
    @required this.items,
    @required this.selectedItem,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: items
                  .map(
                    (e) => RadioListTile(
                      title: Text(e),
                      value: e,
                      groupValue: selectedItem,
                      selected: selectedItem == e,
                      onChanged: onChanged,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
