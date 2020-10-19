import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/controllers/dialog_controller.dart';
import 'package:fluttergetxcontactapp/widgets/widgets.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  static const pageId = 'test_screen';
  final DialogController _dialogCtrl = Get.put(DialogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialogs'),
      ),
      body: Center(
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text('Alert dialog'),
                onTap: () => _showMessageDialog(),
              ),
              ListTile(
                title: Text('Single choice dialog'),
                onTap: () => _showSingleChoiceDialog(
                  title: 'Select one country',
                  items: _dialogCtrl.itemList,
                  selectedItem: _dialogCtrl.selectedItem,
                ),
              ),
              ListTile(
                title: Text('Multiple choice Dialog'),
                onTap: () => _showMultiChoiceDialog(
                  title: 'Select multiple countries',
                  items: _dialogCtrl.itemList,
                  selectedItemList: _dialogCtrl.selectedItemList,
                ),
              ),
              ListTile(
                title: Text('Loading Dialog'),
                onTap: () => LoadingIndicatorWidget.showLoadingIndicator(
                    barrierDismissible: true),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }

  _showMessageDialog() {
    Get.dialog(
      SimpleDialogWidget(
        title: 'Simple dialog',
        content: 'This is a simple dialog',
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              print('Cancel action');
              Get.back(); // closes the dialog
            },
          ),
          FlatButton(
            child: Text("Okay"),
            onPressed: () {
              print('Okay action');
              Get.back(); // closes the dialog
            },
          ),
        ],
      ),
    );
  }

  _showSingleChoiceDialog(
      {String title, List<dynamic> items, dynamic selectedItem}) {
    Get.dialog(
      SingleChoiceDialogWidget(
        title: title,
        items: items,
        selectedItem: selectedItem,
        onChanged: (value) {
          _dialogCtrl.setSelectedItem(value);
          Get.back();
        },
      ),
    );
  }

  _showMultiChoiceDialog(
      {String title, List<dynamic> items, dynamic selectedItemList}) {
    Get.dialog(
      MultiChoiceDialogWidget(
        title: title,
        items: items,
        selectedItemList: selectedItemList,
        handleOnChange: (value) {
          print(value);
          _dialogCtrl.updateCheckList(value);
          Get.back();
        },
      ),
    );
  }
}
