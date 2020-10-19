import 'package:flutter/material.dart';

class MultiChoiceDialogWidget extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final List<dynamic> selectedItemList;
  final Function handleOnChange;

  MultiChoiceDialogWidget({
    @required this.title,
    @required this.items,
    @required this.selectedItemList,
    @required this.handleOnChange,
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
                    (e) => CheckboxListTile(
                      title: Text(e),
                      value: selectedItemList.contains(e),
                      onChanged: (value) {
                        print(value);
                        // print(e);
                        handleOnChange(e);
                      },
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
